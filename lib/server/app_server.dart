import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:dubai_app_studio/server/app_http_failure.dart';
import 'package:dubai_app_studio/server/app_http_services/app_http_services.dart';

class AppServer extends http.BaseClient {
  final AppHistoryHttpService historyService;
  final AppOtpServiceHttpService otpService;
  final AppAccountInfoHttpService accountInfoService;
  final AppRechargeHttpService rechargeService;
  final AppBeneficiaryHttpService beneficiaryService;

  AppServer({
    required this.historyService,
    required this.otpService,
    required this.accountInfoService,
    required this.rechargeService,
    required this.beneficiaryService,
  });

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // simulate waiting for 1 second
    await Future.delayed(const Duration(seconds: 1));

    try {
      if (request.url.path == '/account_info' && request.method == 'GET') {
        return accountInfoService.fetchAccountInfo(request);
      } else if (request.url.path == '/history' && request.method == 'GET') {
        return historyService.fetchHistory(request);
      } else if (request.url.path == '/send_otp' && request.method == 'POST') {
        return otpService.sendOtp(request);
      } else if (request.url.path == '/verify_otp' &&
          request.method == 'POST') {
        return otpService.verifyOtp(request);
      } else if (request.url.path == '/recharge' && request.method == 'POST') {
        return rechargeService.addTransaction(request);
      } else if (request.url.path == '/beneficiaries' &&
          request.method == 'GET') {
        return beneficiaryService.fetchBeneficiaries(request);
      } else if (request.url.path == '/add_beneficiary' &&
          request.method == 'POST') {
        return beneficiaryService.addBeneficiary(request);
      } else if (request.url.path.contains('/beneficiary') &&
          request.method == 'DELETE') {
        return beneficiaryService.deleteBeneficiary(request);
      } else {
        return notFoundResponse(request: request);
      }
    } on Exception catch (_) {
      return AppHttpFailure.response(request: request);
    }
  }

  http.StreamedResponse notFoundResponse(
      {required http.BaseRequest request, String errorMessage = 'Not found'}) {
    final json = jsonEncode({'success': false, 'error': errorMessage});
    final streamedResponse = http.StreamedResponse(
      Stream.fromIterable([utf8.encode(json)]),
      404,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      request: request,
    );
    return streamedResponse;
  }
}
