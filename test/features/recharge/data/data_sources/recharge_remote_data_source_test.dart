import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/core/usecases/send_amount_params.dart';
import 'package:dubai_app_studio/features/recharge/data/data_sources/recharge_remote_data_source.dart';
import 'package:dubai_app_studio/features/recharge/data/models/history_item_model.dart';

import '../../../../mocks/mock_http_client.dart';

void main() {
  late RechargeRemoteDataSource historyRemoteDataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    historyRemoteDataSource = RechargeRemoteDataSource(client: mockHttpClient);
  });

  group('RechargeRemoteDataSource', () {
    final List<HistoryItemModel> tHistory = [
      HistoryItemModel(
        name: "Sarah",
        phoneNumber: "551234567",
        amount: 50.00,
        date: DateTime(24, 6, 1),
      ),
      HistoryItemModel(
        name: "Ali",
        phoneNumber: "551222567",
        amount: 50.00,
        date: DateTime(24, 6, 1),
      ),
      HistoryItemModel(
        name: "Jack",
        phoneNumber: "551234123",
        amount: 50.00,
        date: DateTime(24, 6, 1),
      ),
    ];

    final tHistoryResponse = jsonEncode(tHistory
        .map((e) => {
              'name': e.name,
              'phoneNumber': e.phoneNumber,
              'amount': e.amount,
              'date': e.date.toIso8601String(),
            })
        .toList());

    final tEmptyHistoryResponse = jsonEncode([]);

    final SendAmountParams tParams =
        SendAmountParams(phoneNumber: "551234567", amount: 50.00);
    test(
        'returns List<HistoryItemModel> when getRechargeHistory() is called and response is 200',
        () async {
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response(tHistoryResponse, 200));
      final result = await historyRemoteDataSource.getRechargeHistory();
      expect(result, isA<List<HistoryItemModel>>());
      expect(result, tHistory);
    });

    test(
        'returns empty List<HistoryItemModel> when getRechargeHistory() is called and response is empty list',
        () async {
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response(tEmptyHistoryResponse, 200));
      final result = await historyRemoteDataSource.getRechargeHistory();
      expect(result, isA<List<HistoryItemModel>>());
      expect(result, []);
    });

    test(
        'throw ServerException when when getRechargeHistory() is called and response is 500',
        () async {
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response("", 500));
      expect(() async => await historyRemoteDataSource.getRechargeHistory(),
          throwsA(isA<ServerException>()));
    });

    test('returns true when sendAmount() is called with the right params',
        () async {
      when(mockHttpClient.post(any,
              headers: anyNamed("headers"), body: tParams.toJson()))
          .thenAnswer((_) async => http.Response("success", 200));
      final result = await historyRemoteDataSource.sendAmount(params: tParams);
      expect(result, true);
    });

    test(
        'throw InsufficientBalanceException when sendAmount() is called and response is 402',
        () async {
      when(mockHttpClient.post(any,
              headers: anyNamed("headers"), body: tParams.toJson()))
          .thenAnswer((_) async => http.Response("error", 402));
      expect(
          () async => await historyRemoteDataSource.sendAmount(params: tParams),
          throwsA(isA<InsufficientBalanceException>()));
    });
    test(
        'throw ServerException when sendAmount() is called and response is 500',
        () async {
      when(mockHttpClient.post(any,
              headers: anyNamed("headers"), body: tParams.toJson()))
          .thenAnswer((_) async => http.Response("error", 500));
      expect(
          () async => await historyRemoteDataSource.sendAmount(params: tParams),
          throwsA(isA<ServerException>()));
    });
  });

  // no need to test all status code as they are tested in [Failure test]
}
