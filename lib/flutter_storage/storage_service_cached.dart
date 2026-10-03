import 'storage_service.dart';

class StorageServiceCached {
  static String? token;

  static Future<void> init() async {
    token = await StorageService.getAccessToken();
  }
}
