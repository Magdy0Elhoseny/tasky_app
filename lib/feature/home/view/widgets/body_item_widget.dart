import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/home/model/task_model.dart';

class BodyItemWidget extends StatelessWidget {
  const BodyItemWidget({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    DateTime createdAtDate = DateTime.parse(task.createdAt);
    String formattedDate = DateFormat('dd/MM/yyyy').format(createdAtDate);
    return Expanded(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                task.title
                    .replaceFirst(task.title[0], task.title[0].toUpperCase()),
                style: AppStyels.textStyle16W700.copyWith(
                  color: Color.fromRGBO(36, 37, 44, 1),
                ),
              )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: _getStatusBackgroundColor(task.status),
                ),
                child: Text(
                  task.status.replaceFirst(
                      task.status[0], task.status[0].toUpperCase()),
                  style: AppStyels.textStyleHint12W500.copyWith(
                    color: _getStatusTextColor(task.status),
                  ),
                ),
              )
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
