import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:dubai_app_studio/core/error/error.dart';
import 'package:dubai_app_studio/features/beneficiary/data/models/beneficiary_model.dart';
import 'package:dubai_app_studio/features/beneficiary/domain/entities/beneficiary.dart';

void main() {
  group('BeneficiaryModel', () {
    test('can be instantiated', () {
      const beneficiaryModel = BeneficiaryModel(
        name: 'John Doe',
        phoneNumber: '1234567890',
        isVerified: true,
        totalTransactions: 100.0,
      );
      expect(beneficiaryModel, isNotNull);
    });

    test('is a Beneficiary Entity', () {
      const beneficiaryModel = BeneficiaryModel(
        name: 'John Doe',
        phoneNumber: '1234567890',
        isVerified: true,
        totalTransactions: 100.0,
      );
      expect(beneficiaryModel, isA<Beneficiary>());
    });

    test('toJson returns a valid JSON map', () {
      const beneficiaryModel = BeneficiaryModel(
        name: 'John Doe',
        phoneNumber: '1234567890',
        isVerified: true,
        totalTransactions: 100.0,
      );
      final json = beneficiaryModel.toJson();
      final decodedJson = jsonDecode(json);
      expect(decodedJson, isA<Map<String, dynamic>>());
      expect(decodedJson['name'], 'John Doe');
      expect(decodedJson['phoneNumber'], '1234567890');
      expect(decodedJson['isVerified'], true);
      expect(decodedJson['totalTransactions'], 100.0);
    });

    test('fromJson returns a valid BeneficiaryModel instance', () {
      final json = {
        'name': 'John Doe',
        'phoneNumber': '1234567890',
        'isVerified': true,
        'totalTransactions': 100.0,
      };
      final beneficiaryModel = BeneficiaryModel.fromJson(json);
      expect(beneficiaryModel, isA<BeneficiaryModel>());
      expect(beneficiaryModel.name, 'John Doe');
      expect(beneficiaryModel.phoneNumber, '1234567890');
      expect(beneficiaryModel.isVerified, true);
      expect(beneficiaryModel.totalTransactions, 100.0);
    });

    test('fromJson throws BadResponseException when json is invalid', () {
      final json = {
        'invalid_key': 'invalid_value',
      };
      expect(() => BeneficiaryModel.fromJson(json),
          throwsA(isA<BadResponseException>()));
    });

    test('copyWith returns a new instance with updated values', () {
      const beneficiaryModel = BeneficiaryModel(
        name: 'John Doe',
        phoneNumber: '1234567890',
        isVerified: true,
        totalTransactions: 100.0,
      );
      final updatedModel = beneficiaryModel.copyWith(
        name: 'Jane Doe',
        phoneNumber: '0987654321',
        isVerified: false,
        totalTransactions: 200.0,
      );
      expect(updatedModel.name, 'Jane Doe');
      expect(updatedModel.phoneNumber, '0987654321');
      expect(updatedModel.isVerified, false);
      expect(updatedModel.totalTransactions, 200.0);
    });
  });
}
