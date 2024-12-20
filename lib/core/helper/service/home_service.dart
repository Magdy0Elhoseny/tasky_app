import 'package:dio/dio.dart';
import 'package:tasky_app/core/constants/end_points.dart';
import 'package:tasky_app/core/helper/api/dio_configration.dart';
import 'package:tasky_app/feature/home/model/task_model.dart';

class HomeService {
  final DioConfig _dioConfig = DioConfig();

  Future<List<Task>> getTasks({required int page}) async {
    try {
      final response = await _dioConfig.dio.get(
        EndPoints.getList,
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data; // Directly use response.data
        return data.map((json) => Task.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to load tasks: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      final response =
          await _dioConfig.dio.delete('${EndPoints.delete}/$taskId');
      if (response.statusCode != 200) {
        throw Exception('Failed to delete task');
      }
    } catch (e) {
      throw Exception('Error deleting task: $e');
    }
  }
}
