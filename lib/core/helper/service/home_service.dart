import 'package:dio/dio.dart';
import 'package:tasky_app/core/constants/end_points.dart';
import 'package:tasky_app/core/helper/api/dio_configration.dart';
import 'package:tasky_app/feature/home/model/task_model.dart';

class HomeService {
  final Dio _dio = Dio();
  HomeService() {
    DioConfig().set(_dio);
  }
  Future<List<Task>> getTasks() async {
    try {
      final response = await _dio.get(EndPoints.getList);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Task.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
