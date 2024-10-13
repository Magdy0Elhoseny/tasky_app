import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/constants/end_points.dart';
import 'package:tasky_app/core/helper/api/dio_configration.dart';
import 'package:tasky_app/core/helper/api/token_manager.dart';
import 'package:tasky_app/core/route/controller/route_controller.dart';
import 'package:tasky_app/core/utils/local_database.dart';
import 'package:tasky_app/feature/auth/login/model/auth_model.dart';
import 'package:tasky_app/feature/auth/register/models/register_response_model.dart';

class AuthService {
  final DioConfig config = DioConfig();

  Future<RegisterResponse?> register(Map<String, dynamic> userData) async {
    try {
      final response =
          await config.dio.post(EndPoints.postRegister, data: userData);

      if (response.statusCode == 201 && response.data != null) {
        final registerResponse =
            RegisterResponse.fromJson(response.data as Map<String, dynamic>);
        await LocalStorage.saveToken(registerResponse.accessToken);
        await LocalStorage.saveUserData({
          'refresh_token': registerResponse.refreshToken,
          'display_name': registerResponse.displayName,
        });
        return registerResponse;
      }
      return null;
    } on DioException catch (e) {
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
      final response = await config.dio.post(EndPoints.postLogin, data: {
        'phone': phone,
        'password': password,
      });

      if (response.statusCode == 201 && response.data != null) {
        final authResponse =
            AuthResponse.fromJson(response.data as Map<String, dynamic>);
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

  Future<bool> refreshTokenFromApi() async {
    final String? refreshToken = await TokenManager.getRefreshToken();
    if (refreshToken == null) {
      log('refreshToken not found');
      Get.find<RouteController>().logout();
      return false;
    }
    try {
      final response = await config.dio.get(
        EndPoints.getRefreshToken,
        queryParameters: {'token': refreshToken},
      );

      final newAccessToken = response.data['access_token'];
      await LocalStorage.saveToken(newAccessToken);
      return true;
    } catch (e) {
      log('refreshToken not found');
      Get.find<RouteController>().logout();
      log('=======auth service=======Error refreshing token: $e');
      return false;
    }
  }
}
