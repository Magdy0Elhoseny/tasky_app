import 'package:get/get.dart';
import '../model/profile_model.dart';
import '../../../core/helper/service/profile_service.dart';

class ProfileController extends GetxController {
  final ProfileService _profileService = ProfileService();
  final Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final fetchedProfile = await _profileService.getProfile();
      profile.value = fetchedProfile;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile');
    } finally {
      isLoading.value = false;
    }
  }
}
