import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/route/controller/route_controller.dart';

class ConfigRouting extends StatelessWidget {
  const ConfigRouting({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RouteController>(
      init: RouteController(),
      builder: (controller) => Obx(() => controller.getInitialScreen()),
    );
  }
}
