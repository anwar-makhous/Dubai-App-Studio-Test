part of 'http_services.dart';

class AppBeneficiaryHttpService {
  final AppStorage storage;

  AppBeneficiaryHttpService({required this.storage});

  Future<http.StreamedResponse> addBeneficiary(http.BaseRequest request) async {
    final body = await request.finalize().toBytes();
    final requestBody = jsonDecode(utf8.decode(body));
    final String name = requestBody['name'];
    final String phoneNumber = requestBody['phoneNumber'];

    final String? data = await storage.read(key: 'beneficiaries');
    List<BeneficiaryModel> beneficiaries = [];

    if (data != null) {
      beneficiaries = (jsonDecode(data) as List<dynamic>)
          .map(
            (e) => BeneficiaryModel.fromJson(e),
          )
          .toList();
    }

    if (beneficiaries.length >= AppConfig.maxBeneficiariesCount) {
      return AppHttpFailure.response(
        request: request,
        errorMessage: "You have reached maximum number of beneficiaries",
        statusCode: 401,
      );
    }

    beneficiaries.insert(
        0,
        BeneficiaryModel(
            name: name,
            phoneNumber: phoneNumber,
            isVerified: false,
            totalTransactions: 0.00));

    await storage.write(
        key: 'beneficiaries',
        value: [
          for (BeneficiaryModel element in beneficiaries) element.toJson(),
        ].toString());

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
  }

  Future<http.StreamedResponse> deleteBeneficiary(
      http.BaseRequest request) async {
    final body = await request.finalize().toBytes();
    final requestBody = jsonDecode(utf8.decode(body));
    final String phoneNumber = requestBody['phoneNumber'];

    final String? data = await storage.read(key: 'beneficiaries');
    List<BeneficiaryModel> beneficiaries = [];

    if (data != null) {
      beneficiaries = (jsonDecode(data) as List<dynamic>)
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

    beneficiaries
        .removeWhere((element) => element.phoneNumber == target.phoneNumber);

    await storage.write(
        key: 'beneficiaries',
        value: [
          for (BeneficiaryModel element in beneficiaries) element.toJson(),
        ].toString());

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
  }

  Future<http.StreamedResponse> fetchBeneficiaries(
      http.BaseRequest request) async {
    final String? data = await storage.read(key: 'beneficiaries');
    final beneficiaries = data ?? "[]";
    final streamedResponse = http.StreamedResponse(
      Stream.fromIterable([utf8.encode(beneficiaries)]),
      200,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      request: request,
    );
    return streamedResponse;
  }
}
