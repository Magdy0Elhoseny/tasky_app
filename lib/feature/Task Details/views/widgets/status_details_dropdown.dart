import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/Task%20Details/controller/details_controller.dart';

class StatusDetailsDropdown extends GetView<DetailsController> {
  const StatusDetailsDropdown({super.key});

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
                  value: controller.selectedStatus.value.isNotEmpty
                      ? controller.selectedStatus.value
                      : controller.task.value!.status,
                  items: ['waiting', 'in progress', 'finished']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              color: AppStyels.primaryColor),
                          const SizedBox(width: 8),
                          Text(value),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedStatus.value = newValue;
                    }
                  },
                  hint: const Text('Select Status'),
                )),
          ),
        ),
      ],
    );
  }
}
