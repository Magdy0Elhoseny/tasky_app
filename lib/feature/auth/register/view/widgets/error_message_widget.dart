import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/feature/auth/register/Controller/register_controller.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget({super.key, required this.controller});
  final RegisterController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.errorMessage.value.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          )
        : const SizedBox.shrink());
  }
}
