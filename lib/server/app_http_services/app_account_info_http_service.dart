part of 'app_http_services.dart';

class AppAccountInfoHttpService {
  final AppStorage storage;

  AppAccountInfoHttpService({required this.storage});

  Future<http.StreamedResponse> fetchAccountInfo(
      http.BaseRequest request) async {
    AccountInfoModel accountInfoModel =
        const AccountInfoModel(balance: 20000.00, totalTransactions: 0.0);
    final String? data = await storage.read(key: 'accountInfo');
    if (data != null) {
      accountInfoModel = AccountInfoModel.fromJson(jsonDecode(data));
    } else {
      await storage.write(key: 'accountInfo', value: accountInfoModel.toJson());
    }
    final json = accountInfoModel.toJson();
    final streamedResponse = http.StreamedResponse(
      Stream.fromIterable([utf8.encode(json)]),
      200,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      request: request,
    );
    return streamedResponse;
  }
}
