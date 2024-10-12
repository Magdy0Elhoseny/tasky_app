import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:tasky_app/core/constants/end_points.dart';
import 'package:tasky_app/core/constants/urls.dart';
import 'package:tasky_app/core/helper/api/dio_configration.dart';
import 'package:tasky_app/feature/add task/model/add_task_model.dart';

class AddTaskService {
  final Dio _dio = Dio();

  AddTaskService() {
    DioConfig().set(_dio);
  }

  Future<bool> addTask(AddTaskModel task, String token) async {
    try {
      final response = await _dio.post(
        '${AppUrls.baseUrl}${EndPoints.postCreate}',
        data: task.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to add task: ${response.statusMessage}',
        );
      }
    } catch (e) {
      throw Exception('Error adding task: $e');
    }
  }

  Future<String?> uploadImage(File imageFile, String token) async {
    try {
      String fileName = imageFile.path.split('/').last;
      String mimeType = _getMimeType(fileName);

      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: MediaType.parse(mimeType),
        ),
      });

      final response = await _dio.request(
        '${AppUrls.baseUrl}${EndPoints.postUploadImage}',
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          method: 'POST',
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(json.encode(response.data));
        return response.data['image'];
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

  String _getMimeType(String fileName) {
    if (fileName.endsWith('.jpg') || fileName.endsWith('.jpeg')) {
      return 'image/jpeg';
    } else if (fileName.endsWith('.png')) {
      return 'image/png';
    } else if (fileName.endsWith('.gif')) {
      return 'image/gif';
    } else {
      return 'application/octet-stream'; // Default to binary data if type is unknown
    }
  }
}
