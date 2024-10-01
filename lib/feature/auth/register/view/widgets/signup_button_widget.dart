import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/Ui/custom_button.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/auth/register/Controller/register_controller.dart';

Widget buildSignUpButton(RegisterController controller) {
  return Obx(() => controller.isLoading.value
      ? const Center(child: CircularProgressIndicator())
      : SizedBox(
          width: double.infinity,
          child: CustomButton(
            backgroundColor: AppStyels.primaryColor,
            textColor: Colors.white,
            onPressed: controller.signUp,
            borderRadius: BorderRadius.circular(12),
            buttonChild: Text(
              'Sign Up',
              style: AppStyels.textStyle19W700.copyWith(color: Colors.white),
            ),
          ),
        ));
}
