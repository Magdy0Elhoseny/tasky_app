import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/helper/service/auth_service.dart';
import 'package:tasky_app/core/route/controller/route_controller.dart';
import 'package:tasky_app/feature/auth/login/model/user_data_model.dart';
import 'package:tasky_app/feature/auth/register/models/register_response_model.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController experienceYearsController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RouteController routeController = Get.find<RouteController>();
  final AuthService _authService = AuthService();
  final RxBool isPasswordHidden = true.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedCountryCode = '+20'.obs;
  final RxString selectedExperienceLevel = 'junior'.obs;

  void updateCountryCode(String code) {
    selectedCountryCode.value = code;
  }

  void updateExperienceLevel(String? level) {
    if (level != null) {
      selectedExperienceLevel.value = level.toLowerCase();
    }
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  bool validateInputs() {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        experienceYearsController.text.isEmpty ||
        addressController.text.isEmpty ||
        passwordController.text.isEmpty) {
      errorMessage.value = 'Please fill in all fields';
      return false;
    }
    if (passwordController.text.length < 6) {
      errorMessage.value = 'Password must be at least 6 characters long';
      return false;
    }
    return true;
  }

  Future<void> signUp() async {
    errorMessage.value = '';
    if (!validateInputs()) return;

    isLoading.value = true;
    try {
      String fullPhoneNumber =
          '${selectedCountryCode.value}${phoneController.text}';
      UserData userData = UserData(
        phone: fullPhoneNumber,
        password: passwordController.text,
        displayName: nameController.text,
        experienceYears: int.parse(experienceYearsController.text),
        address: addressController.text,
        level: selectedExperienceLevel.value,
      );
      log('Sending registration data: ${userData.toJson()}');
      RegisterResponse? response =
          await _authService.register(userData.toJson());
      if (response != null && response.id.isNotEmpty) {
        routeController.goToHome();
      } else {
        errorMessage.value = 'Registration failed. Please try again.';
      }
    } on DioException catch (e) {
      log('DioError: ${e.toString()}');
      if (e.response != null) {
        log('Response data: ${e.response!.data}');
        if (e.response!.statusCode == 422) {
          errorMessage.value =
              e.response!.data['message'] ?? 'Phone number is already in use';
        } else {
          errorMessage.value =
              'Server error: ${e.response!.data['message'] ?? 'Unknown error'}';
        }
      } else {
        errorMessage.value = 'Network error: ${e.message}';
      }
    } catch (e) {
      log('Unexpected error: ${e.toString()}');
      errorMessage.value = 'An unexpected error occurred. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void goToSignIn() {
    routeController.goToLogin();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    experienceYearsController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
