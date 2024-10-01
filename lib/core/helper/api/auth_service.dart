import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tasky_app/core/constants/end_points.dart';
import 'package:tasky_app/core/helper/api/dio_configration.dart';
import 'package:tasky_app/core/utils/local_database.dart';
import 'package:tasky_app/feature/auth/login/model/auth_model.dart';
import 'package:tasky_app/feature/auth/register/models/register_response_model.dart';

class AuthService {
  final Dio dio;

  AuthService() : dio = Dio() {
    DioConfig().set(dio);
  }

  Future<RegisterResponse?> register(Map<String, dynamic> userData) async {
    try {
      final response = await dio.post(EndPoints.postRegister, data: userData);

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
      final response = await dio.post(EndPoints.postLogin, data: {
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
      print('Login error: $e');
      return null;
    }
  }

  // Keep the refreshToken method as is
}
