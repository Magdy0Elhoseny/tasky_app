import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/add%20task/views/widgets/due_date_field.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task Details', style: AppStyels.textStyle16W700),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AssetManager.arrowBackIcon),
          ),
          actions: [
            PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: () {},
                        child: const Text('Edit',
                            style: AppStyels.textStyle16W500),
                      ),
                      PopupMenuItem(
                        value: () {},
                        child: Text(
                          'Delete',
                          style: AppStyels.textStyle16W500.copyWith(
                            color: const Color.fromRGBO(255, 125, 83, 1),
                          ),
                        ),
                      ),
                    ]),
          ],
        ),
        body: Column(
          children: [
            const Text('Task Details', style: AppStyels.textStyle24W700),
            Text('Details',
                style: AppStyels.textStyleHint14W400
                    .copyWith(color: AppStyels.textfeildColor)),
            DueDateField(),
            const TaskStatusWidget(),
          ],
        ),
      ),
    );
  }
}

class TaskStatusWidget extends StatelessWidget {
  const TaskStatusWidget({super.key});

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
                  // value: controller.selectedPriority.value,
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
                      // controller.updatePriority(newValue);
                    }
                  },
                )),
          ),
        ),
      ],
    );
  }
}
