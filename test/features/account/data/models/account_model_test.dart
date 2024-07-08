import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/account/data/models/account_model.dart';
import 'package:dubai_app_studio/features/account/domain/entities/account_info.dart';

void main() {
  group('AccountInfoModel', () {
    test('can be instantiated', () {
      const accountInfoModel = AccountInfoModel(
        balance: 100.0,
        totalTransactions: 5.0,
      );
      expect(accountInfoModel, isNotNull);
    });

    test('is a AccountInfo Entity', () {
      const accountInfoModel = AccountInfoModel(
        balance: 100.0,
        totalTransactions: 5.0,
      );
      expect(accountInfoModel, isA<AccountInfo>());
    });

    test('toJson returns a valid JSON map', () {
      const accountInfoModel = AccountInfoModel(
        balance: 100.0,
        totalTransactions: 5.0,
      );
      final json = accountInfoModel.toJson();
      final decodedJson = jsonDecode(json);
      expect(decodedJson, isA<Map<String, dynamic>>());
      expect(decodedJson['balance'], 100.0);
      expect(decodedJson['totalTransactions'], 5.0);
    });

    test('fromJson returns a valid AccountInfoModel instance', () {
      final json = jsonEncode({
        'balance': 100.0,
        'totalTransactions': 5.0,
      });
      final accountInfoModel = AccountInfoModel.fromJson(json);
      expect(accountInfoModel, isA<AccountInfoModel>());
      expect(accountInfoModel.balance, 100.0);
      expect(accountInfoModel.totalTransactions, 5.0);
    });

    test('fromJson throws BadResponseException when json is invalid', () {
      final json = {
        'invalid_key': 'invalid_value',
      };
      expect(() => AccountInfoModel.fromJson(json),
          throwsA(isA<BadResponseException>()));
    });
  });
}
