import 'package:saasf/core/storage/hive_service.dart';

/// Secure Storage Service
/// For sensitive data that requires encryption
/// Currently using Hive, but can be replaced with flutter_secure_storage if needed
class SecureStorage {
  /// Store sensitive value
  static Future<void> set(String key, String value) async {
    // Using Hive for now, can be replaced with flutter_secure_storage
    await HiveService.set(key, value);
  }

  /// Get sensitive value
  static String? get(String key) {
    return HiveService.get<String>(key);
  }

  /// Remove sensitive value
  static Future<void> remove(String key) async {
    await HiveService.remove(key);
  }
}
