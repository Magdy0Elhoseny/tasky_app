import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';
import 'package:tasky_app/feature/home/view/widgets/task_list_item.dart';

Widget buildTaskList(HomeController controller) {
  return Obx(() => ListView.builder(
        shrinkWrap: true,
        itemCount: controller.filteredTasks.length,
        itemBuilder: (context, index) {
          final task = controller.filteredTasks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TaskItem(task: task, controller: controller),
          );
        },
      ));
}
