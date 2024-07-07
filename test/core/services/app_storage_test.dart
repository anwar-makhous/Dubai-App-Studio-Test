import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dubai_app_studio/core/services/app_storage.dart';

// Generate a MockFlutterSecureStorage using the mockito package
@GenerateMocks([FlutterSecureStorage])
import 'app_storage_test.mocks.dart';

void main() {
  late AppStorageImpl appStorage;
  late MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    appStorage = AppStorageImpl(flutterSecureStorage: mockFlutterSecureStorage);
  });

  group('read', () {
    test('should return value when there is one in storage', () async {
      // arrange
      const testKey = 'testKey';
      const testValue = 'testValue';

      when(mockFlutterSecureStorage.read(key: testKey))
          .thenAnswer((_) async => testValue);

      // act
      final result = await appStorage.read(key: testKey);

      // assert
      verify(mockFlutterSecureStorage.read(key: testKey));
      expect(result, testValue);
    });

    test('should return null when there is no value in storage', () async {
      // arrange
      const testKey = 'testKey';

      when(mockFlutterSecureStorage.read(key: testKey))
          .thenAnswer((_) async => null);

      // act
      final result = await appStorage.read(key: testKey);

      // assert
      verify(mockFlutterSecureStorage.read(key: testKey));
      expect(result, null);
    });
  });

  group('write', () {
    test('should call FlutterSecureStorage to save the data', () async {
      // arrange
      const testKey = 'testKey';
      const testValue = 'testValue';

      when(mockFlutterSecureStorage.write(key: testKey, value: testValue))
          .thenAnswer((_) async => Future.value());

      // act
      await appStorage.write(key: testKey, value: testValue);

      // assert
      verify(mockFlutterSecureStorage.write(key: testKey, value: testValue));
    });
  });

  group('delete', () {
    test('should call FlutterSecureStorage to delete the data', () async {
      // arrange
      const testKey = 'testKey';

      when(mockFlutterSecureStorage.delete(key: testKey))
          .thenAnswer((_) async => Future.value());

      // act
      await appStorage.delete(key: testKey);

      // assert
      verify(mockFlutterSecureStorage.delete(key: testKey));
    });
  });

  group('deleteAll', () {
    test('should call FlutterSecureStorage to delete all data', () async {
      // arrange
      when(mockFlutterSecureStorage.deleteAll())
          .thenAnswer((_) async => Future.value());

      // act
      await appStorage.deleteAll();

      // assert
      verify(mockFlutterSecureStorage.deleteAll());
    });
  });
}
