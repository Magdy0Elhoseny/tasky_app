import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../constants/end_points.dart';
import '../../utils/local_database.dart';
import '../api/dio_configration.dart';
import '../../../feature/Profile/model/profile_model.dart';

class ProfileService {
  final DioConfig _dioConfig = Get.find<DioConfig>();

  ProfileService() {
    _dioConfig.set(Dio());
  }

  Future<ProfileModel> getProfile() async {
    try {
      final token = LocalStorage.getToken();
      final response = await _dioConfig.dio.get(
        EndPoints.getProfile,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      throw Exception('Error fetching profile: $e');
    }
  }
}
