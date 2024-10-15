import 'package:dio/dio.dart';
import '../../constants/end_points.dart';
import '../../utils/local_database.dart';
import '../api/dio_configration.dart';
import '../../../feature/Profile/model/profile_model.dart';

class ProfileService {
  final DioConfig config = DioConfig();

  Future<ProfileModel> getProfile() async {
    try {
      final token = LocalStorage.getToken();
      final response = await config.dio.get(
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
