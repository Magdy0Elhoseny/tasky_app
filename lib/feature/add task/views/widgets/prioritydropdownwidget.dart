import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/core/asset manager/asset_manager.dart';
import 'package:tasky_app/feature/add task/controller/add_task_controller.dart';

class PriorityDropdownWidget extends StatelessWidget {
  PriorityDropdownWidget({super.key});

  final AddTaskController controller = Get.find<AddTaskController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppStyels.secondaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
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
                              color: AppStyels.primaryColor),
                          const SizedBox(width: 8),
                          Text(value),
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
}
