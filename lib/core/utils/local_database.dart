import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static const String _tokenBox = 'tokenBox';
  static const String _userBox = 'userBox';
  static const String _tokenKey = 'authToken';
  static const String _userKey = 'userData';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_tokenBox);
    await Hive.openBox(_userBox);
  }

  static Future<void> saveToken(String token) async {
    final box = Hive.box(_tokenBox);
    await box.put(_tokenKey, token);
  }

  static String? getToken() {
    final box = Hive.box(_tokenBox);
    return box.get(_tokenKey);
  }

  static Future<void> deleteToken() async {
    final box = Hive.box(_tokenBox);
    await box.delete(_tokenKey);
  }

  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    final box = Hive.box(_userBox);
    await box.put(_userKey, userData);
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final box = await Hive.openBox(_userBox);
    final data = box.get(_userKey);
    return data != null ? Map<String, dynamic>.from(data) : null;
  }

  static Future<void> deleteUserData() async {
    final box = Hive.box(_userBox);
    await box.delete(_userKey);
  }

  static Future<void> clearAll() async {
    await Hive.box(_tokenBox).clear();
    await Hive.box(_userBox).clear();
  }
}
