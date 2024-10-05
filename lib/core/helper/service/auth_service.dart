import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tasky_app/core/constants/end_points.dart';
import 'package:tasky_app/core/helper/api/dio_configration.dart';
import 'package:tasky_app/core/helper/api/token_manager.dart';
import 'package:tasky_app/core/utils/local_database.dart';
import 'package:tasky_app/feature/auth/login/model/auth_model.dart';
import 'package:tasky_app/feature/auth/register/models/register_response_model.dart';

class AuthService {
  final Dio _dio = Dio();

  AuthService() {
    DioConfig().set(_dio);
  }

  Future<RegisterResponse?> register(Map<String, dynamic> userData) async {
    try {
      final response = await _dio.post(EndPoints.postRegister, data: userData);

      if (response.statusCode == 201 && response.data != null) {
        final registerResponse = RegisterResponse.fromJson(response.data);
        await LocalStorage.saveToken(registerResponse.accessToken);
        await LocalStorage.saveUserData({
          'refresh_token': registerResponse.refreshToken,
          'display_name': registerResponse.displayName,
        });
        return registerResponse;
      }
      return null;
    } on DioError catch (e) {
      if (e.response != null) {
        log('Register error: ${e.response!.statusCode} - ${e.response!.data}');
        if (e.response!.statusCode == 500) {
          throw Exception(
              'Server error: Please try again later or contact support.');
        } else {
          throw Exception(
              'Server error: ${e.response!.statusMessage ?? 'Unknown error'}');
        }
      } else {
        log('Register error: ${e.message}');
        throw Exception(
            'Network error: Please check your internet connection.');
      }
    } catch (e) {
      log('Register error: $e');
      throw Exception('Unexpected error: Please try again.');
    }
  }

  Future<AuthResponse?> login(String phone, String password) async {
    try {
      final response = await _dio.post(EndPoints.postLogin, data: {
        'phone': phone,
        'password': password,
      });

      if (response.statusCode == 201 && response.data != null) {
        final authResponse = AuthResponse.fromJson(response.data);
        await LocalStorage.saveToken(authResponse.accessToken);
        await LocalStorage.saveUserData({
          'refresh_token': authResponse.refreshToken,
          'user_id': authResponse.id,
        });
        return authResponse;
      }
      return null;
    } catch (e) {
      log('Login error: $e');
      return null;
    }
  }

  Future<String?> refreshToken() async {
    final String? refreshToken = await TokenManager().getRefreshToken();
    if (refreshToken == null) {
      return null;
    }

    try {
      final response = await _dio.post(EndPoints.getRefreshToken, data: {
        'refresh_token': refreshToken,
      });

      if (response.statusCode == 200 && response.data != null) {
        final newAccessToken = response.data['access_token'];
        await TokenManager().saveTokens(newAccessToken, refreshToken);
        return newAccessToken;
      } else if (response.statusCode == 401) {
        await TokenManager().clearTokens();
        return null;
      }
    } catch (e) {
      log('Error refreshing token: $e');
    }

    return null;
  }
}
