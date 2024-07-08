import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/account/data/data_sources/account_remote_data_source.dart';
import 'package:dubai_app_studio/features/account/data/models/account_model.dart';

import '../../../../mocks/mock_http_client.dart';

void main() {
  late AccountRemoteDataSource accountRemoteDataSource;
  late MockClient mockHttpClient;

  AccountInfoModel tAccountInfo =
      const AccountInfoModel(balance: 500, totalTransactions: 50);

  setUp(() {
    mockHttpClient = MockClient();
    accountRemoteDataSource = AccountRemoteDataSource(client: mockHttpClient);
  });

  group('AccountRemoteDataSource', () {
    test('returns AccountInfoModel when response is 200', () async {
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response(tAccountInfo.toJson(), 200));
      final accountInfo = await accountRemoteDataSource.getAccountInfo();
      expect(accountInfo, isA<AccountInfoModel>());
      expect(accountInfo.balance, tAccountInfo.balance);
      expect(accountInfo.totalTransactions, tAccountInfo.totalTransactions);
    });

    test('throws UnauthorizedException when response is 401', () async {
      when(mockHttpClient.get(any)).thenAnswer((_) async =>
          http.Response(jsonEncode({'error': 'Unauthorized'}), 401));
      expect(() async => await accountRemoteDataSource.getAccountInfo(),
          throwsA(isA<UnauthorizedException>()));
    });

    test('throws InsufficientBalanceException when response is 402', () async {
      when(mockHttpClient.get(any)).thenAnswer((_) async =>
          http.Response(jsonEncode({'error': 'Insufficient balance'}), 402));
      accountRemoteDataSource = AccountRemoteDataSource(client: mockHttpClient);
      expect(() async => await accountRemoteDataSource.getAccountInfo(),
          throwsA(isA<InsufficientBalanceException>()));
    });

    test('throws NotFoundException when response is 404', () async {
      when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(jsonEncode({'error': 'Not found'}), 404));
      accountRemoteDataSource = AccountRemoteDataSource(client: mockHttpClient);
      expect(() async => await accountRemoteDataSource.getAccountInfo(),
          throwsA(isA<NotFoundException>()));
    });

    test('throws ServerException when response is 500', () async {
      when(mockHttpClient.get(any)).thenAnswer((_) async =>
          http.Response(jsonEncode({'error': 'Internal Server Error'}), 500));
      accountRemoteDataSource = AccountRemoteDataSource(client: mockHttpClient);
      expect(() async => await accountRemoteDataSource.getAccountInfo(),
          throwsA(isA<ServerException>()));
    });

    test(
        'throws UnknownException when response is not 200 nor 401, 402, 404, 500',
        () async {
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response("anything", 300));
      accountRemoteDataSource = AccountRemoteDataSource(client: mockHttpClient);
      expect(() async => await accountRemoteDataSource.getAccountInfo(),
          throwsA(isA<UnknownException>()));
    });
    test('throws BadResponseException when response is not invalid', () async {
      when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(jsonEncode({'key': 'value'}), 200));
      accountRemoteDataSource = AccountRemoteDataSource(client: mockHttpClient);
      expect(() async => await accountRemoteDataSource.getAccountInfo(),
          throwsA(isA<BadResponseException>()));
    });
    test('throws BadResponseException when response is empty', () async {
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response(jsonEncode(''), 200));
      accountRemoteDataSource = AccountRemoteDataSource(client: mockHttpClient);
      expect(() async => await accountRemoteDataSource.getAccountInfo(),
          throwsA(isA<BadResponseException>()));
    });
  });

  // no need to test all status code as they are tested in [Failure test]
}
