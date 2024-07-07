part of 'app_http_services.dart';

class AppRechargeHttpService {
  final AppStorage storage;

  AppRechargeHttpService({required this.storage});

  Future<http.StreamedResponse> addTransaction(http.BaseRequest request) async {
    final body = await request.finalize().toBytes();
    final requestBody = jsonDecode(utf8.decode(body));
    final double amount = requestBody['amount'];
    final String phoneNumber = requestBody['phoneNumber'];

    final String? beneficiariesData = await storage.read(key: 'beneficiaries');
    List<BeneficiaryModel> beneficiaries = [];

    if (beneficiariesData != null) {
      beneficiaries = (jsonDecode(beneficiariesData) as List<dynamic>)
          .map(
            (e) => BeneficiaryModel.fromJson(e),
          )
          .toList();
    } else {
      return AppHttpFailure.response(
        request: request,
        errorMessage: "Beneficiary not found",
        statusCode: 404,
      );
    }

    late BeneficiaryModel target;
    try {
      target = beneficiaries
          .firstWhere((element) => element.phoneNumber == phoneNumber);
    } catch (_) {
      return AppHttpFailure.response(
        request: request,
        errorMessage: "Beneficiary not found",
        statusCode: 404,
      );
    }

    final String? accountInfoData = await storage.read(key: 'accountInfo');
    if (accountInfoData != null) {
      // update account info
      AccountInfoModel accountInfoModel =
          AccountInfoModel.fromJson(jsonDecode(accountInfoData));
      const double extraCharges = 1;
      if ((accountInfoModel.balance - extraCharges) >= amount) {
        double newBalance = accountInfoModel.balance - amount - extraCharges;
        double newTotalTransactions =
            accountInfoModel.totalTransactions + amount;
        AccountInfoModel newAccountInfoModel = AccountInfoModel(
            balance: newBalance, totalTransactions: newTotalTransactions);
        await storage.write(
            key: 'accountInfo', value: newAccountInfoModel.toJson());

        // update history
        final String? historyData = await storage.read(key: 'history');
        List<HistoryItemModel> history = [];
        if (historyData != null) {
          history = (jsonDecode(historyData) as List<dynamic>)
              .map((e) => HistoryItemModel.fromJson(e))
              .toList();
        }

        history.insert(
            0,
            HistoryItemModel(
                name: target.name,
                phoneNumber: target.phoneNumber,
                amount: amount,
                date: DateTime.now()));

        await storage.write(
            key: 'history',
            value: [
              for (HistoryItemModel element in history) element.toJson(),
            ].toString());

        // update beneficiary total transactions
        int index = beneficiaries
            .indexWhere((element) => element.phoneNumber == target.phoneNumber);
        beneficiaries.removeWhere(
            (element) => element.phoneNumber == target.phoneNumber);
        beneficiaries.insert(
            index,
            target.copyWith(
                totalTransactions: target.totalTransactions + amount));
        await storage.write(
            key: 'beneficiaries',
            value: [
              for (BeneficiaryModel element in beneficiaries) element.toJson(),
            ].toString());

        // response
        final json = jsonEncode({'success': true});
        final streamedResponse = http.StreamedResponse(
          Stream.fromIterable([utf8.encode(json)]),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          request: request,
        );
        return streamedResponse;
      } else {
        return AppHttpFailure.response(
          request: request,
          errorMessage: "Insufficient balance",
          statusCode: 402,
        );
      }
    } else {
      return AppHttpFailure.response(
        request: request,
        errorMessage: "Account info not found",
        statusCode: 404,
      );
    }
  }
}
