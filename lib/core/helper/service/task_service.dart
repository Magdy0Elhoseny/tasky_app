import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/constants/end_points.dart';
import 'package:tasky_app/core/helper/api/dio_configration.dart';
import 'package:tasky_app/feature/Task%20Details/model/details_task_model.dart';

class TaskService {
  final DioConfig _dioConfig = Get.find<DioConfig>();

  TaskService() {
    _dioConfig.set(Dio());
  }

  Future<DetailsTaskModel> getOneTask(String taskId) async {
    try {
      final response = await _dioConfig.dio.get('${EndPoints.getOne}/$taskId');
      if (response.statusCode == 200) {
        return DetailsTaskModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get task');
      }
    } catch (e) {
      throw Exception('Error getting task: $e');
    }
  }

  Future<void> editTask(String token, DetailsTaskModel task) async {
    try {
      final response = await _dioConfig.dio.put(
        "${EndPoints.putEdit}/${task.id}",
        data: task.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) => status! < 500,
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to edit task');
      }
    } catch (e) {
      throw Exception('Error Editing task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      //final taskId = task.id;
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
