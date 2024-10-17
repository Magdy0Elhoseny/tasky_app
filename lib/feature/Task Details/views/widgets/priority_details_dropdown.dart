import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/Task%20Details/controller/details_controller.dart';

class PriorityDetailsDropdown extends GetView<DetailsController> {
  const PriorityDetailsDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.only(
            left: 24,
            right: 10,
            top: 4,
            bottom: 4,
          ),
          decoration: BoxDecoration(
            color: AppStyels.secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: Obx(() => DropdownButton<String>(
                  icon: SvgPicture.asset(AssetManager.dropdownButtonIcon),
                  isExpanded: true,
                  value: controller.selectedPriority.value.isNotEmpty
                      ? controller.selectedPriority.value
                      : controller.task.value!.priority,
                  items: ['low', 'medium', 'high'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          SvgPicture.asset(AssetManager.flagIcon,
                              color: _getPriorityTextColor(value)),
                          const SizedBox(width: 8),
                          Text(
                              "${value.replaceFirst(value[0], value[0].toUpperCase())} Priority",
                              style: AppStyels.textStyle16W700.copyWith(
                                  color: _getPriorityTextColor(value))),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedPriority.value = newValue;
                    }
                  },
                )),
          ),
        ),
      ],
    );
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
