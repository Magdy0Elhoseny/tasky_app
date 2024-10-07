import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tasky_app/core/constants/end_points.dart';
import 'package:tasky_app/core/constants/urls.dart';
import 'package:tasky_app/core/helper/api/dio_configration.dart';

class ImageUploadService {
  final Dio _dio = Dio();
  ImageUploadService() {
    DioConfig().set(_dio);
  }

  Future<String?> uploadImage(File imageFile, String token) async {
    try {
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image':
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });

      final response = await _dio.request(
        '${AppUrls.baseUrl}${EndPoints.postUploadImage}',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          method: 'POST',
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        log(json.encode(response.data));
        return response.data['url'];
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Image upload failed with status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error uploading image: ${e.toString()}');
    }
  }
}
