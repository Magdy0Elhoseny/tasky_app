import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/core/asset manager/asset_manager.dart';
import 'package:tasky_app/feature/add task/controller/add_task_controller.dart';

class DueDateField extends StatelessWidget {
  final AddTaskController controller = Get.find<AddTaskController>();

  DueDateField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Due date', style: AppStyels.textStyleHint14W500),
        const SizedBox(height: 8),
        Container(
          color: AppStyels.secondaryColor.withOpacity(0.2),
          child: Obx(() => TextField(
                controller:
                    TextEditingController(text: controller.dueDate.value),
                readOnly: true,
                decoration: InputDecoration(
                  hintText: controller.getDueDate() == null
                      ? controller.getDueDate()
                      : 'Select date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: AppStyels.secondaryColor.withOpacity(0.2)),
                  ),
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(AssetManager.calendarIcon,
                        color: AppStyels.primaryColor),
                    onPressed: () => _selectDate(context),
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      controller.updateDueDate(formattedDate);
    }
  }
}
