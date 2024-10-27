import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';
import 'package:tasky_app/feature/home/model/task_model.dart';
import 'package:tasky_app/core/route/app_route.dart';
import 'package:tasky_app/feature/home/view/widgets/body_item_widget.dart';
import 'package:tasky_app/feature/home/view/widgets/home_popup.dart';
import 'package:tasky_app/feature/home/view/widgets/image_item_widget.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final HomeController controller;
  const TaskItem({super.key, required this.task, required this.controller});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () {
        Get.toNamed(AppRoutes.details, arguments: task);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageItemWidget(task: task),
          const SizedBox(width: 12),
          BodyItemWidget(task: task),
          HomePopupWidget(controller: controller, task: task),
        ],
      ),
    );
  }
}
