import 'package:dio/dio.dart';
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
        '${AppUrls.baseUrl}/todos',
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
}
