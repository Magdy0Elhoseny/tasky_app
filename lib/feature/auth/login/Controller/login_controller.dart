import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/api/auth_service.dart';
import 'package:tasky_app/core/route/controller/route_controller.dart';
import 'package:tasky_app/feature/auth/login/model/auth_model.dart';

class LoginController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RouteController routeController = Get.find<RouteController>();
  final AuthService _authService = AuthService();
  final RxBool isPasswordHidden = true.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedCountryCode = '+20'.obs; // Default to Egypt

  void updateCountryCode(String code) {
    selectedCountryCode.value = code;
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  bool validateInputs() {
    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
      errorMessage.value = 'Please fill in all fields';
      return false;
    }
    if (passwordController.text.length < 6) {
      errorMessage.value = 'Password must be at least 6 characters long';
      return false;
    }
    return true;
  }

  Future<void> signIn() async {
    errorMessage.value = '';
    if (!validateInputs()) return;

    isLoading.value = true;
    try {
      String fullPhoneNumber =
          '${selectedCountryCode.value}${phoneController.text}';
      AuthResponse? authResponse = await _authService.login(
        fullPhoneNumber,
        passwordController.text,
      );
      if (authResponse != null && authResponse.id.isNotEmpty) {
        routeController.goToHome();
      } else {
        errorMessage.value = 'Invalid credentials';
      }
    } catch (e) {
      log('Login error: $e');
      errorMessage.value = 'An error occurred. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void goToSignUp() {
    routeController.goToRegister();
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
