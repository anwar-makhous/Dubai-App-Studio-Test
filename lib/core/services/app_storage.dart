import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AppStorage {
  Future<String?> read({required String key});
  Future<void> write({required String key, required String value});
  Future<void> delete({required String key});
  Future<void> deleteAll();
}

class AppStorageImpl extends AppStorage {
  final FlutterSecureStorage flutterSecureStorage;
  AppStorageImpl({required this.flutterSecureStorage});

  @override
  Future<void> delete({required String key}) async {
    await flutterSecureStorage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await flutterSecureStorage.deleteAll();
  }

  @override
  Future<String?> read({required String key}) async {
    return await flutterSecureStorage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    await flutterSecureStorage.write(key: key, value: value);
  }
}
