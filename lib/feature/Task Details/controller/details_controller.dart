import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/route/app_route.dart';
import 'package:tasky_app/core/utils/local_database.dart';
import 'package:tasky_app/feature/Task%20Details/model/details_task_model.dart';
import 'package:tasky_app/core/helper/service/task_service.dart';
import 'package:tasky_app/feature/home/model/task_model.dart';

class DetailsController extends GetxController {
  final TaskService _taskService = TaskService();
  final Rx<DetailsTaskModel?> task = Rx<DetailsTaskModel?>(null);
  final RxBool isLoading = true.obs;
  final RxString selectedPriority = ''.obs;
  final RxString selectedStatus = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final dynamic argument = Get.arguments;
    if (argument is Task) {
      getOneTask(argument.id);
    } else if (argument is String) {
      getOneTask(argument);
    }
  }

  void getOneTask(String taskId) async {
    try {
      isLoading.value = true;
      final detailsTask = await _taskService.getOneTask(taskId);
      task.value = detailsTask;
      selectedPriority.value = detailsTask.priority;
      selectedStatus.value = detailsTask.status;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch task details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void editTask() async {
    if (task.value != null) {
      final updatedTask = DetailsTaskModel(
        id: task.value!.id,
        status: selectedStatus.value,
        image: task.value!.image,
        title: task.value!.title,
        desc: task.value!.desc,
        priority: selectedPriority.value,
        createdAt: task.value!.createdAt,
        updatedAt: task.value!.updatedAt,
      );
      try {
        isLoading.value = true;
        final token = LocalStorage.getToken();

        if (task.value!.priority != selectedPriority.value ||
            task.value!.status != selectedStatus.value) {
          await _taskService.editTask(token!, updatedTask);
          Get.snackbar('Success', 'Task updated successfully');
          Get.offAllNamed(AppRoutes.home);
        } else {
          Get.snackbar('Error', 'No changes made');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to update task: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  void deleteTask() {
    Get.defaultDialog(
      title: 'Delete Task',
      middleText: 'Are you sure you want to delete this task?',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        try {
          isLoading.value = true;
          await _taskService.deleteTask(task.value!.id);
          Get.back(); //? Close the dialog
          Get.back(); //! to the task list
          Get.snackbar('Success', 'Task deleted successfully');
        } catch (e) {
          Get.snackbar('Error', 'Failed to delete task: $e');
        } finally {
          isLoading.value = false;
        }
      },
    );
  }

  String getToggleStatusButtonText() {
    return task.value!.status.toLowerCase() == 'finished'
        ? 'Mark as In Progress'
        : 'Mark as Finished';
  }

  void updatePriority(String newPriority) async {
    try {
      isLoading.value = true;
      selectedPriority.value = newPriority;
      Get.snackbar('Success', 'Task priority updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task priority: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateStatus(String newStatus) async {
    try {
      isLoading.value = true;

      selectedStatus.value = newStatus;
      Get.snackbar('Success', 'Task status updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task status: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
