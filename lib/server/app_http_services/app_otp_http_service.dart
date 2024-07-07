part of 'app_http_services.dart';

class AppOtpServiceHttpService {
  final AppStorage storage;

  AppOtpServiceHttpService({required this.storage});

  Future<http.StreamedResponse> sendOtp(http.BaseRequest request) async {
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

  Future<http.StreamedResponse> verifyOtp(http.BaseRequest request) async {
    final body = await request.finalize().toBytes();
    final requestBody = jsonDecode(utf8.decode(body));
    final String otp = requestBody['otp'];
    final String phoneNumber = requestBody['phoneNumber'];
    if (otp == '0000') {
      // fetch the beneficiary to update verification status
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

      int index = beneficiaries
          .indexWhere((element) => element.phoneNumber == target.phoneNumber);
      beneficiaries
          .removeWhere((element) => element.phoneNumber == target.phoneNumber);

      beneficiaries.insert(index, target.copyWith(isVerified: true));

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
    } else {
      return AppHttpFailure.response(
        request: request,
        errorMessage: "Wrong otp",
        statusCode: 401,
      );
    }
  }
}
