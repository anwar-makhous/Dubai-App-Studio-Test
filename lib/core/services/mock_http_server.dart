import 'dart:convert';

import 'package:dubai_app_studio/core/services/app_storage.dart';
import 'package:dubai_app_studio/features/beneficiary/data/models/beneficiary_model.dart';
import 'package:http/http.dart' as http;

import 'package:dubai_app_studio/features/home/data/models/balance_model.dart';

class MockHttpServer extends http.BaseClient {
  final AppStorage storage;

  MockHttpServer({required this.storage});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // simulate waiting for 1 seconds
    await Future.delayed(const Duration(seconds: 1));

    if (request.url.path == '/balance' && request.method == 'GET') {
      return _getBalance(request);
    } else if (request.url.path == '/send_otp' && request.method == 'POST') {
      return _sendOtp(request);
    } else if (request.url.path == '/recharge' && request.method == 'POST') {
      return _recharge(request);
    } else if (request.url.path == '/add_beneficiary' &&
        request.method == 'POST') {
      return _addBeneficiary(request);
    } else if (request.url.path == '/beneficiaries' &&
        request.method == 'GET') {
      return _getBeneficiaries(request);
    } else if (request.url.path == '/verify_otp' && request.method == 'POST') {
      return _verifyOtp(request);
    } else {
      final streamedResponse = http.StreamedResponse(
        Stream.fromIterable(['Not found'.codeUnits]),
        404,
        request: request,
      );
      return streamedResponse;
    }
  }

  Future<http.StreamedResponse> _getBalance(http.BaseRequest request) async {
    double mockBalance = 20000.0;
    final String? data = await storage.read(key: 'balance');
    if (data != null) {
      mockBalance = double.parse(data);
    } else {
      await storage.write(key: 'balance', value: mockBalance.toString());
    }
    final balanceModel = BalanceModel(balance: mockBalance);
    final json = jsonEncode(balanceModel.toJson());
    final streamedResponse = http.StreamedResponse(
      Stream.fromIterable([utf8.encode(json)]),
      200,
      headers: {
        'Content-Type': 'application/json',
      },
      request: request,
    );
    return streamedResponse;
  }

  Future<http.StreamedResponse> _sendOtp(http.BaseRequest request) async {
    final json = jsonEncode({'otp': '0000'});
    final streamedResponse = http.StreamedResponse(
      Stream.fromIterable([utf8.encode(json)]),
      200,
      headers: {
        'Content-Type': 'application/json',
      },
      request: request,
    );
    return streamedResponse;
  }

  Future<http.StreamedResponse> _verifyOtp(http.BaseRequest request) async {
    final body = await request.finalize().toBytes();
    final requestBody = json.decode(utf8.decode(body));
    final String otp = requestBody['otp'];
    if (otp == '0000') {
      final json = jsonEncode({'success': true});
      final streamedResponse = http.StreamedResponse(
        Stream.fromIterable([utf8.encode(json)]),
        200,
        headers: {
          'Content-Type': 'application/json',
        },
        request: request,
      );
      return streamedResponse;
    } else {
      final json = jsonEncode({'success': false});
      final streamedResponse = http.StreamedResponse(
        Stream.fromIterable([utf8.encode(json)]),
        401,
        headers: {
          'Content-Type': 'application/json',
        },
        request: request,
      );
      return streamedResponse;
    }
  }

  Future<http.StreamedResponse> _recharge(http.BaseRequest request) async {
    final body = await request.finalize().toBytes();
    final requestBody = json.decode(utf8.decode(body));
    final double amount = requestBody['amount'];

    final String? data = await storage.read(key: 'balance');
    if (data != null) {
      double mockBalance = double.parse(data);
      if (mockBalance >= amount) {
        mockBalance -= amount;
        await storage.write(key: 'balance', value: mockBalance.toString());
        final json = jsonEncode({'success': true});
        final streamedResponse = http.StreamedResponse(
          Stream.fromIterable([utf8.encode(json)]),
          200,
          headers: {
            'Content-Type': 'application/json',
          },
          request: request,
        );
        return streamedResponse;
      } else {
        final json =
            jsonEncode({'success': false, 'error': 'Insufficient balance'});
        final streamedResponse = http.StreamedResponse(
          Stream.fromIterable([utf8.encode(json)]),
          402,
          headers: {
            'Content-Type': 'application/json',
          },
          request: request,
        );
        return streamedResponse;
      }
    } else {
      final json = jsonEncode({'success': false, 'error': 'Balance not found'});
      final streamedResponse = http.StreamedResponse(
        Stream.fromIterable([utf8.encode(json)]),
        404,
        headers: {
          'Content-Type': 'application/json',
        },
        request: request,
      );
      return streamedResponse;
    }
  }

  Future<http.StreamedResponse> _addBeneficiary(
      http.BaseRequest request) async {
    final body = await request.finalize().toBytes();
    final requestBody = jsonDecode(utf8.decode(body));
    final String name = requestBody['name'];
    final String number = requestBody['number'];

    final String? beneficiariesString =
        await storage.read(key: 'beneficiaries');
    List<BeneficiaryModel> beneficiaries = [];

    if (beneficiariesString != null) {
      beneficiaries = (jsonDecode(beneficiariesString) as List<dynamic>)
          .map(
            (e) => BeneficiaryModel.fromJson(e),
          )
          .toList();
    }

    beneficiaries
        .add(BeneficiaryModel(name: name, number: number, isVerified: false));

    await storage.write(
        key: 'beneficiaries',
        value: [
          for (BeneficiaryModel element in beneficiaries)
            jsonEncode(element.toJson()),
        ].toString());

    final json = jsonEncode({'success': true});
    final streamedResponse = http.StreamedResponse(
      Stream.fromIterable([utf8.encode(json)]),
      200,
      headers: {
        'Content-Type': 'application/json',
      },
      request: request,
    );
    return streamedResponse;
  }

  Future<http.StreamedResponse> _getBeneficiaries(
      http.BaseRequest request) async {
    final String? beneficiariesString =
        await storage.read(key: 'beneficiaries');
    List<BeneficiaryModel> beneficiaries = [];

    if (beneficiariesString != null) {
      beneficiaries = (jsonDecode(beneficiariesString) as List<dynamic>)
          .map(
            (e) => BeneficiaryModel.fromJson(e),
          )
          .toList();
    }

    final json = jsonEncode(beneficiaries);
    final streamedResponse = http.StreamedResponse(
      Stream.fromIterable([utf8.encode(json)]),
      200,
      headers: {
        'Content-Type': 'application/json',
      },
      request: request,
    );
    return streamedResponse;
  }
}
