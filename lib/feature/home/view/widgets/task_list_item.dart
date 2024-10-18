import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';
import 'package:tasky_app/feature/home/model/task_model.dart';
import 'package:tasky_app/core/route/app_route.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final HomeController controller;
  const TaskItem({super.key, required this.task, required this.controller});

  @override
  Widget build(BuildContext context) {
    DateTime createdAtDate = DateTime.parse(task.createdAt);
    String formattedDate = DateFormat('dd/MM/yyyy').format(createdAtDate);

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.details, arguments: task),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Center(
              widthFactor: 1,
              heightFactor: 1.6,
              child: Image.network(
                task.image,
                width: 64,
                height: 64,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      task.title.replaceFirst(
                          task.title[0], task.title[0].toUpperCase()),
                      style: AppStyels.textStyle16W700.copyWith(
                        color: Color.fromRGBO(36, 37, 44, 1),
                      ),
                    )),
                    SizedBox(
                      child: Chip(
                        side: BorderSide.none,
                        labelStyle: AppStyels.textStyleHint12W500.copyWith(
                          color: _getStatusTextColor(task.status),
                        ),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 3),
                        label: Text(
                          task.status.replaceFirst(
                              task.status[0], task.status[0].toUpperCase()),
                        ),
                        backgroundColor: _getStatusBackgroundColor(task.status),
                      ),
                    ),
                  ],
                ),
                Text(
                  task.desc,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyels.textStyleHint14W400.copyWith(
                    color: Color.fromRGBO(36, 37, 44, 0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AssetManager.flagIcon,
                            height: 16,
                            width: 16,
                            color: _getPriorityTextColor(task.priority)),
                        const SizedBox(width: 8),
                        Text(
                          task.priority.replaceFirst(
                              task.priority[0], task.priority[0].toUpperCase()),
                          style: AppStyels.textStyleHint12W500.copyWith(
                            color: _getPriorityTextColor(task.priority),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      formattedDate,
                      style: AppStyels.textStyleHint12W400,
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: PopupMenuButton(
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
              offset: Offset(0, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'waiting':
        return Color.fromRGBO(255, 125, 83, 1);
      case 'in progress':
        return AppStyels.primaryColor;
      case 'finished':
        return Color.fromRGBO(0, 135, 255, 1);
      default:
        return Colors.grey;
    }
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'waiting':
        return Color.fromRGBO(255, 228, 242, 1);
      case 'in progress':
        return Color.fromRGBO(240, 236, 255, 1);
      case 'finished':
        return Color.fromRGBO(227, 242, 255, 1);
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityTextColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return Color.fromRGBO(0, 135, 255, 1);
      case 'medium':
        return Color.fromRGBO(95, 51, 225, 1);
      case 'high':
        return Color.fromRGBO(255, 125, 83, 1);
      default:
        return Colors.grey;
    }
  }
}
/*


 */