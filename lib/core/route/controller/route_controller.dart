import 'package:get/get.dart';
import 'package:tasky_app/core/route/app_route.dart';
import 'package:tasky_app/core/utils/local_database.dart';

class RouteController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkInitialRoute();
  }

  Future<bool> isFirstLaunch() async {
    return LocalStorage.getToken() == null;
  }

  void checkInitialRoute() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulating splash screen delay
    if (await isFirstLaunch()) {
      Get.offAllNamed(AppRoutes.onborading);
    } else if (LocalStorage.getToken() != null) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  void goToLogin() {
    Get.offAllNamed(AppRoutes.login);
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.register);
  }

  void goToHome() {
    Get.offAllNamed(AppRoutes.home);
  }

  void logout() async {
    await LocalStorage.clearAll();
    goToLogin();
  }
}
