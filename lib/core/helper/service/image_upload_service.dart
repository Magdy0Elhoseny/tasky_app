import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tasky_app/core/constants/urls.dart';

class ImageUploadService {
  final Dio _dio = Dio();

  Future<String?> uploadImage(File imageFile, String token) async {
    try {
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image":
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });

      final response = await _dio.post(
        '${AppUrls.baseUrl}/upload/image',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        return response
            .data['url']; // Adjust this based on the actual response structure
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Image upload failed with status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}
