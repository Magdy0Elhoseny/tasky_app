import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';

Widget filterChip(String label, bool isSelected) {
  final HomeController controller = Get.find<HomeController>();
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: GestureDetector(
      onTap: () => controller.setFilter(label),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppStyels.primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );
}
