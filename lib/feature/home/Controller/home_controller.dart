import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/service/home_service.dart';
import 'package:tasky_app/core/helper/service/task_service.dart';
import 'package:tasky_app/core/route/app_route.dart';
import 'package:tasky_app/core/route/controller/route_controller.dart';
import 'package:tasky_app/feature/home/model/task_model.dart';

class HomeController extends GetxController {
  final HomeService _homeService = HomeService();
  final TaskService _taskService = TaskService();
  RxList<Task> tasks = <Task>[].obs;
  RxBool isLoading = true.obs;
  RxString selectedFilter = 'All'.obs;
  RxList<Task> filteredTasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    isLoading.value = true;
    try {
      final List<Task> fetchedTasks = await _homeService.getTasks();
      tasks.assignAll(fetchedTasks);
      _applyFilter();
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 403) {
        Get.snackbar('Error', 'Your session has expired. Please login again.');
        Get.find<RouteController>().logout();
      } else {
        Get.snackbar('Error', 'Failed to fetch tasks. Please try again.');
      }
      log('Error fetching tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    _applyFilter();
  }

  void _applyFilter() {
    switch (selectedFilter.value) {
      case 'All':
        filteredTasks.assignAll(tasks);
        break;
      case 'Inprogress':
        filteredTasks.assignAll(
            tasks.where((task) => task.status.toLowerCase() == 'in progress'));
        break;
      case 'Waiting':
        filteredTasks.assignAll(
            tasks.where((task) => task.status.toLowerCase() == 'waiting'));
        break;
      case 'Finished':
        filteredTasks.assignAll(
            tasks.where((task) => task.status.toLowerCase() == 'finished'));
        break;
    }
  }

  goToAddTask() {
    Get.toNamed(AppRoutes.addTask);
  }

  goToProfile() {
    Get.toNamed(AppRoutes.profile);
  }

  void logOut() {
    Get.find<RouteController>().logout();
  }

  void deleteTask(String taskId) {
    Get.defaultDialog(
      title: 'Delete Task',
      middleText: 'Are you sure you want to delete this task?',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        try {
          isLoading.value = true;
          await _taskService.deleteTask(taskId);
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
}
