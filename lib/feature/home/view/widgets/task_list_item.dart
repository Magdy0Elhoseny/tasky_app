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
    String formattedDate = DateFormat('dd-MM-yyyy').format(createdAtDate);

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.details, arguments: task),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(task.image),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      task.title,
                      style: const TextStyle(color: Colors.black),
                    )),
                    SizedBox(
                      child: Chip(
                        label: Text(task.status,
                            style: AppStyels.textStyleHint12W500
                                .copyWith(color: Colors.white)),
                        backgroundColor: _getStatusColor(task.status),
                      ),
                    ),
                    PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'edit') {
                            Get.offAllNamed(AppRoutes.details, arguments: task);
                          } else if (value == 'delete') {
                            controller.deleteTask(task.id);
                          }
                        },
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit',
                                    style: AppStyels.textStyle16W500),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text(
                                  'Delete',
                                  style: AppStyels.textStyle16W500.copyWith(
                                    color:
                                        const Color.fromRGBO(255, 125, 83, 1),
                                  ),
                                ),
                              ),
                            ]),
                  ],
                ),
                Text(task.desc, maxLines: 1, overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AssetManager.flagIcon,
                            height: 16, width: 16),
                        const SizedBox(width: 8),
                        Text(
                          task.priority,
                          style: AppStyels.textStyleHint12W400
                              .copyWith(color: AppStyels.primaryColor),
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
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'waiting':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'finished':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
