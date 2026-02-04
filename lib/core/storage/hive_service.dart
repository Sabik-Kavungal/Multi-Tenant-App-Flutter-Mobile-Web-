import 'package:hive_flutter/hive_flutter.dart';

/// Hive Storage Service
/// Simple key-value storage for local data persistence
class HiveService {
  static const String _boxName = 'app_storage';
  static Box? _box;

  /// Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  /// Get value by key
  static T? get<T>(String key) {
    return _box?.get(key) as T?;
  }

  /// Set value by key
  static Future<void> set(String key, dynamic value) async {
    await _box?.put(key, value);
  }

  /// Remove value by key
  static Future<void> remove(String key) async {
    await _box?.delete(key);
  }

  /// Clear all data
  static Future<void> clear() async {
    await _box?.clear();
  }

  /// Check if key exists
  static bool containsKey(String key) {
    return _box?.containsKey(key) ?? false;
  }
}

/// Storage Keys
class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String tokenExpiresAt = 'token_expires_at';
  static const String user = 'user';
}
