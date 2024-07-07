import 'dart:convert';

import 'package:dubai_app_studio/features/recharge/domain/entities/history_item.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/recharge/data/models/history_item_model.dart';

void main() {
  group('HistoryItemModel', () {
    test('can be instantiated', () {
      final historyItemModel = HistoryItemModel(
        name: 'John Doe',
        phoneNumber: '1234567890',
        amount: 100.0,
        date: DateTime.parse('2022-01-01T12:00:00.000Z'),
      );
      expect(historyItemModel, isNotNull);
    });
    test('is a HistoryItem Entity', () {
      final historyItemModel = HistoryItemModel(
        name: 'John Doe',
        phoneNumber: '1234567890',
        amount: 100.0,
        date: DateTime.parse('2022-01-01T12:00:00.000Z'),
      );
      expect(historyItemModel, isA<HistoryItem>());
    });

    test('toJson returns a valid JSON map', () {
      final historyItemModel = HistoryItemModel(
        name: 'John Doe',
        phoneNumber: '1234567890',
        amount: 100.0,
        date: DateTime.parse('2022-01-01T12:00:00.000Z'),
      );
      final json = historyItemModel.toJson();
      final decodedJson = jsonDecode(json);
      expect(decodedJson, isA<Map<String, dynamic>>());
      expect(decodedJson['name'], 'John Doe');
      expect(decodedJson['phoneNumber'], '1234567890');
      expect(decodedJson['amount'], 100.0);
      expect(decodedJson['date'], '2022-01-01T12:00:00.000Z');
    });

    test('fromJson returns a valid HistoryItemModel instance', () {
      final json = {
        'name': 'John Doe',
        'phoneNumber': '1234567890',
        'amount': 100.0,
        'date': '2022-01-01T12:00:00.000Z',
      };
      final historyItemModel = HistoryItemModel.fromJson(json);
      expect(historyItemModel, isA<HistoryItemModel>());
      expect(historyItemModel.name, 'John Doe');
      expect(historyItemModel.phoneNumber, '1234567890');
      expect(historyItemModel.amount, 100.0);
      expect(historyItemModel.date, DateTime.parse('2022-01-01T12:00:00.000Z'));
    });

    test('fromJson throws BadResponseException when json is invalid', () {
      final json = {
        'invalid_key': 'invalid_value',
      };
      expect(() => HistoryItemModel.fromJson(json),
          throwsA(isA<BadResponseException>()));
    });
  });
}
