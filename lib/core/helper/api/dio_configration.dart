import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tasky_app/core/constants/urls.dart';
import 'package:tasky_app/core/helper/service/auth_service.dart';
import 'package:tasky_app/core/helper/api/token_manager.dart';
import 'package:tasky_app/core/route/controller/route_controller.dart';
import 'package:get/get.dart';

class DioConfig {
  void set(Dio dio) {
    dio.options.baseUrl = AppUrls.baseUrl;
    dio.options.connectTimeout = const Duration(milliseconds: 60000);
    dio.options.receiveTimeout = const Duration(milliseconds: 60000);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenManager().getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioError error, handler) async {
          if (error.response?.statusCode == 401) {
            if (await _refreshToken(dio)) {
              return handler.resolve(await _retry(dio, error.requestOptions));
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

  Future<bool> _refreshToken(Dio dio) async {
    try {
      final newToken = await AuthService().refreshToken();
      if (newToken != null) {
        await TokenManager()
            .saveTokens(newToken, await TokenManager().getRefreshToken() ?? '');
        return true;
      }
    } catch (e) {
      log('Error refreshing token: $e');
    }
    Get.find<RouteController>().logout();
    return false;
  }

  Future<dynamic> _retry(Dio dio, RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
