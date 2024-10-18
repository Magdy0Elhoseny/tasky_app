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

  DioConfig._internal() {
    dio = Dio();
    _initializeDio();
  }

  static final DioConfig _instance = DioConfig._internal();

  factory DioConfig() {
    return _instance;
  }

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
            bool isSuccess = await AuthService().refreshTokenFromApi();
            if (!isSuccess) {
              if (TokenManager().getAccessToken() == null) {
                Get.find<RouteController>().logout();
              }
              return handler.next(error);
            }
            error.requestOptions.headers['Authorization'] =
                'Bearer ${TokenManager().getAccessToken()}';
            return handler.resolve(await dio.fetch(error.requestOptions));
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

  void updateToken(String newToken) {
    dio.options.headers['Authorization'] = 'Bearer $newToken';
  }
}
