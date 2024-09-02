import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants/app_keys.dart';

abstract interface class ISecureService {
  Future<void> saveAccessToken(String value);
  Future<void> saveRefresToken(String value);

  Future<String?> get accessToken;
  Future<String?> get refreshToken;

  Future<void> clearToken();
}

class SecureService implements ISecureService {
  final FlutterSecureStorage secureStorage;
  SecureService({required this.secureStorage});

  @override
  Future<void> saveAccessToken(String value) async {
    try {
      final token = value;
      await secureStorage.write(key: AppKeys.accessToken, value: token);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<void> saveRefresToken(String value) async {
    try {
      final token = value;
      await secureStorage.write(key: AppKeys.refreshToken, value: token);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<String?> get accessToken async {
    try {
      final token = await secureStorage.read(key: AppKeys.accessToken);
      return token;
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<String?> get refreshToken async {
    try {
      final token = await secureStorage.read(key: AppKeys.refreshToken);
      return token;
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      await secureStorage.delete(key: AppKeys.accessToken);
      await secureStorage.delete(key: AppKeys.refreshToken);
    } catch (e, s) {
      Error.throwWithStackTrace(e, s);
    }
  }
}
