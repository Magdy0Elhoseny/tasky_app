import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/add%20task/controller/add_task_controller.dart';
import 'package:tasky_app/feature/add%20task/views/widgets/add_image.dart';
import 'package:tasky_app/feature/add%20task/views/widgets/due_date_field.dart';
import 'package:tasky_app/feature/add%20task/views/widgets/priority_addtask_dropdown_widget.dart';

class AddTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTaskController());
  }
}

class AddTaskView extends GetView<AddTaskController> {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new task', style: AppStyels.textStyle16W700),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(AssetManager.arrowBackIcon),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddImageButton(),
            const SizedBox(height: 16),
            _buildTextField('Task title', 'Enter title here...',
                onChanged: controller.title.call),
            const SizedBox(height: 16),
            _buildTextField('Task Description', 'Enter description here...',
                maxLines: 5, onChanged: controller.description.call),
            const SizedBox(height: 16),
            const Text('Priority', style: AppStyels.textStyleHint14W500),
            const SizedBox(height: 8),
            PriorityaddtaskDropdownWidget(),
            const SizedBox(height: 16),
            DueDateField(),
            const SizedBox(height: 24),
            _buildAddTaskButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      {int maxLines = 1, void Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyels.textStyleHint14W500),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddTaskButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await controller.addTask();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppStyels.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text('Add task',
            style: AppStyels.textStyle16W700.copyWith(color: Colors.white)),
      ),
    );
  }
}
