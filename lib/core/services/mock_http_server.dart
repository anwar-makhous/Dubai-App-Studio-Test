import 'dart:convert';

import 'package:dubai_app_studio/core/services/app_storage.dart';
import 'package:http/http.dart' as http;

import 'package:dubai_app_studio/features/home/data/models/balance_model.dart';

class MockHttpServer extends http.BaseClient {
  final AppStorage storage;

  MockHttpServer({required this.storage});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // simulate waiting for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    if (request.url.path == '/balance' && request.method == 'GET') {
      return _getBalance(request);
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
}
