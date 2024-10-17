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
                  value: controller.selectedStatus.value.isNotEmpty
                      ? controller.selectedStatus.value
                      : controller.task.value!.status,
                  items: ['waiting', 'in progress', 'finished']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Text(
                              value.replaceFirst(
                                  value[0], value[0].toUpperCase()),
                              style: AppStyels.textStyle16W700
                                  .copyWith(color: _getStatusTextColor(value))),
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
}
