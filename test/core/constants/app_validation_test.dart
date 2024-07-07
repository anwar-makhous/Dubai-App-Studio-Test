import 'package:flutter_test/flutter_test.dart';

import 'package:dubai_app_studio/core/constants/app_validation.dart';

void main() {
  group('AppValidation.nameValidation', () {
    test('Valid name', () {
      expect(AppValidation.nameValidation('Ahmad_#'), null);
      expect(AppValidation.nameValidation('John Smith'), null);
      expect(AppValidation.nameValidation('Jack123'), null);
    });

    test('Invalid name', () {
      expect(AppValidation.nameValidation('Sam Smith Jackson the third'),
          ValidationErrorMessage.invalidName);
    });

    test('Empty name', () {
      expect(
          AppValidation.nameValidation(''), ValidationErrorMessage.emptyField);
    });
  });

  group('AppValidation.phoneNumberValidation', () {
    test('Valid phone number', () {
      expect(AppValidation.phoneNumberValidation('551234567'), null);
    });

    test('Invalid phone number', () {
      expect(AppValidation.phoneNumberValidation('66666991234567'),
          ValidationErrorMessage.invalidPhoneNumber);
      expect(AppValidation.phoneNumberValidation('1414'),
          ValidationErrorMessage.invalidPhoneNumber);
      expect(AppValidation.phoneNumberValidation('+971991234567'),
          ValidationErrorMessage.invalidPhoneNumber);
    });

    test('Empty phone number', () {
      expect(AppValidation.phoneNumberValidation(''),
          ValidationErrorMessage.emptyField);
    });
  });
}
