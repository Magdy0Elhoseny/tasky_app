import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/core/asset manager/asset_manager.dart';
import 'package:tasky_app/feature/add task/controller/add_task_controller.dart';

class PriorityaddtaskDropdownWidget extends StatelessWidget {
  PriorityaddtaskDropdownWidget({super.key});

  final AddTaskController controller = Get.find<AddTaskController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppStyels.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: Obx(() => DropdownButton<String>(
                  icon: SvgPicture.asset(AssetManager.dropdownButtonIcon),
                  isExpanded: true,
                  value: controller.selectedPriority.value,
                  items: ['Low Priority', 'Medium Priority', 'High Priority']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          SvgPicture.asset(AssetManager.flagIcon,
                              color: _getPriorityTextColor(value)),
                          const SizedBox(width: 8),
                          Text(value,
                              style: AppStyels.textStyle16W700.copyWith(
                                  color: _getPriorityTextColor(value))),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.updatePriority(newValue);
                    }
                  },
                )),
          ),
        ),
      ],
    );
  }

  Color _getPriorityTextColor(String priority) {
    switch (priority) {
      case 'Low Priority':
        return Color.fromRGBO(0, 135, 255, 1);
      case 'Medium Priority':
        return Color.fromRGBO(95, 51, 225, 1);
      case 'High Priority':
        return Color.fromRGBO(255, 125, 83, 1);
      default:
        return Colors.grey;
    }
  }
}
