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
  final DioConfig config = DioConfig();
  Future<bool> addTask(AddTaskModel task) async {
    try {
      final response = await config.dio.post(
        '${AppUrls.baseUrl}${EndPoints.postCreate}',
        data: task.toJson(),
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      // show dialog
      return false;
    }
  }

  Future<String?> uploadImage(File imageFile) async {
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

      final response = await config.dio.post(
        '${AppUrls.baseUrl}${EndPoints.postUploadImage}',
        data: formData,
      );

      return response.data['image'];
    } catch (e) {
      // show snackBar
      return null;
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
