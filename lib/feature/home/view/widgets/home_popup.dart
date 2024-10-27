import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/route/app_route.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';
import 'package:tasky_app/feature/home/model/task_model.dart';

class HomePopupWidget extends StatelessWidget {
  const HomePopupWidget(
      {super.key, required this.task, required this.controller});
  final Task task;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: PopupMenuButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.more_vert, color: Colors.black),
        onSelected: (value) {
          if (value == 'edit') {
            Get.offAllNamed(AppRoutes.details, arguments: task);
          } else if (value == 'delete') {
            controller.deleteTask(task.id);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.black),
                const SizedBox(width: 8),
                Text('Edit', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, color: Colors.red),
                const SizedBox(width: 8),
                Text('Delete', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
        offset: Offset(0, 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Colors.white,
      ),
    );
  }
}
