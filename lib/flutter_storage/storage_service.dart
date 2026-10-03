import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const _storage = FlutterSecureStorage();

  static const String access_token = 'access_token';
  static const String refresh_token = 'refresh_token';

  static Future<void> saveToken({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: access_token, value: accessToken);
    await _storage.write(key: refresh_token, value: refreshToken);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: access_token);
  }

   static Future<void> clear() async {
    await _storage.deleteAll();
  }
}
