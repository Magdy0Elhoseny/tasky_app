import 'package:get/get.dart';
import 'package:tasky_app/core/utils/local_database.dart';

class TokenManager {
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await LocalStorage.saveToken(accessToken);
    await LocalStorage.saveUserData({refreshTokenKey: refreshToken});
  }

  String? getAccessToken() {
    return LocalStorage.getToken();
  }

  static Future<String?> getRefreshToken() async {
    final userData = await LocalStorage.getUserData();
    return userData?['refresh_token'] as String?;
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
      Get.snackbar('Error', "Unexpected error: Please try again.");
      return false;
    }
  }
}
