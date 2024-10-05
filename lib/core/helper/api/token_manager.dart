import 'dart:developer';

import 'package:tasky_app/core/utils/local_database.dart';

class TokenManager {
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await LocalStorage.saveToken(accessToken);
    await LocalStorage.saveUserData({refreshTokenKey: refreshToken});
  }

  Future<String?> getAccessToken() async {
    return LocalStorage.getToken();
  }

  Future<String?> getRefreshToken() async {
    final userData = LocalStorage.getUserData();
    return userData?[refreshTokenKey];
  }

  Future<void> clearTokens() async {
    await LocalStorage.deleteToken();
    await LocalStorage.deleteUserData();
  }

  Future<bool> refreshTokens(
      String newAccessToken, String newRefreshToken) async {
    try {
      await saveTokens(newAccessToken, newRefreshToken);
      return true;
    } catch (e) {
      log('Error refreshing tokens: $e');
      return false;
    }
  }
}
