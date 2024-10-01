import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/route/app_route.dart';
import 'package:tasky_app/core/utils/local_database.dart';
import 'package:tasky_app/feature/auth/login/view/login_view.dart';
import 'package:tasky_app/feature/auth/splash/view/splash_view.dart';

import 'package:tasky_app/feature/auth/onborading/view/onboarding_view.dart';

class RouteController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxBool _isFirstLaunch = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkInitialRoute();
  }

  Future<void> checkInitialRoute() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulating splash screen delay
    _isFirstLaunch.value = await isFirstLaunch();
    _isLoading.value = false;
  }

  Future<bool> isFirstLaunch() async {
    return LocalStorage.getToken() == null;
  }

  Widget getInitialScreen() {
    if (_isLoading.value) {
      return const SplashView();
    } else if (_isFirstLaunch.value) {
      return const OnboardingView();
    } else {
      return const LoginView();
    }
  }

  void goToOnboarding() {
    Get.offAllNamed(AppRoutes.onborading);
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
