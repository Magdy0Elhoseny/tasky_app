import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tasky_app/core/constants/urls.dart';
import 'package:tasky_app/core/helper/service/auth_service.dart';
import 'package:tasky_app/core/helper/api/token_manager.dart';
import 'package:tasky_app/core/route/controller/route_controller.dart';

class DioConfig {
  late Dio dio;

  // Private constructor
  DioConfig._internal() {
    dio = Dio();
    _initializeDio();
  }

  // Static instance
  static final DioConfig _instance = DioConfig._internal();

  // Factory constructor to return the same instance
  factory DioConfig() {
    return _instance;
  }

  // Initialize Dio with settings and interceptors
  void _initializeDio() {
    dio.options.baseUrl = AppUrls.baseUrl;
    dio.options.connectTimeout = const Duration(milliseconds: 60000);
    dio.options.receiveTimeout = const Duration(milliseconds: 60000);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = TokenManager().getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401) {
            try {
              final AuthService authService = AuthService();
              bool isSuccess = await authService.refreshTokenFromApi();
              if (!isSuccess) {
                Get.find<RouteController>().logout();
                return handler.next(error);
              }
              error.requestOptions.headers['Authorization'] =
                  'Bearer ${TokenManager().getAccessToken()}';
              return handler.resolve(await dio.fetch(error.requestOptions));
            } catch (e) {
              Get.find<RouteController>().logout();
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: true,
        ),
      );
    }
  }

  // Method to update the token in Dio
  void updateToken(String newToken) {
    dio.options.headers['Authorization'] = 'Bearer $newToken';
  }
}
