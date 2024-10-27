import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/service/home_service.dart';
import 'package:tasky_app/core/route/app_route.dart';
import 'package:tasky_app/core/route/controller/route_controller.dart';
import 'package:tasky_app/feature/home/model/task_model.dart';

class HomeController extends GetxController {
  final HomeService _homeService = HomeService();

  RxList<Task> tasks = <Task>[].obs;
  RxBool isLoading = true.obs;
  late RxString selectedFilter;
  List<String> filterTypes = [
    'All',
    'In Progress',
    'Waiting',
    'Finished',
  ];
  RxList<Task> filteredTasks = <Task>[].obs;
  int currentPage = 1;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    selectedFilter = 'All'.obs;
    initialFetch();
  }

  Future<void> initialFetch() async {
    await fetchTasks();
    isLoading.value = false;
  }

  void resetPagination() {
    currentPage = 1;
    hasMore = true;
    tasks.clear();
    filteredTasks.clear();
  }

  Future<void> fetchTasks() async {
    if (!hasMore ||
        (isLoading.value && tasks.isNotEmpty) ||
        selectedFilter.value != 'All') {
      return;
    }
    isLoading.value = true;
    try {
      final List<Task> fetchedTasks =
          await _homeService.getTasks(page: currentPage);
      if (fetchedTasks.isEmpty) {
        hasMore = false;
      } else {
        tasks.addAll(fetchedTasks);
        currentPage++;
      }
      _applyFilter();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tasks. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    _applyFilter();
  }

  void _applyFilter() {
    if (selectedFilter.value == 'All') {
      filteredTasks.assignAll(tasks);
    } else {
      filteredTasks.assignAll(tasks.where((task) =>
          task.status.toLowerCase() == selectedFilter.value.toLowerCase()));
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

          Get.back();
          await _homeService.deleteTask(taskId);
          fetchTasks();
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
