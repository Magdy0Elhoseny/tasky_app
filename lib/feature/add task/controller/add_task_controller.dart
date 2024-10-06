import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/service/add_task_service.dart';
import 'package:tasky_app/core/helper/service/image_upload_service.dart';
import 'package:tasky_app/core/utils/local_database.dart';
import 'package:tasky_app/feature/add%20task/model/add_task_model.dart';

class AddTaskController extends GetxController {
  final ImageUploadService _imageUploadService = ImageUploadService();
  final AddTaskService _addTaskService = AddTaskService();
  final RxString _imageUrl = RxString('');
  final RxBool _isUploading = RxBool(false);
  final RxString title = RxString('');
  final RxString description = RxString('');
  final RxString dueDate = RxString('');
  final RxString selectedPriority = 'Medium Priority'.obs;

  String get imageUrl => _imageUrl.value;
  bool get isUploading => _isUploading.value;

  Future<void> addTask() async {
    if (title.value.isEmpty ||
        description.value.isEmpty ||
        dueDate.value.isEmpty) {
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }

    final String token = LocalStorage.getToken() ?? '';

    try {
      String? uploadedImageUrl;
      if (_imageUrl.value.isNotEmpty) {
        uploadedImageUrl =
            await _imageUploadService.uploadImage(File(_imageUrl.value), token);
      }

      final task = AddTaskModel(
        image: uploadedImageUrl ?? AssetManager.onbording,
        title: title.value,
        desc: description.value,
        priority: _convertPriority(selectedPriority.value),
        dueDate: dueDate.value,
      );

      final result = await _addTaskService.addTask(task, token);
      if (result) {
        Get.snackbar('Success', 'Task added successfully');
        Get.back();
      }
    } catch (e) {
      if (e is DioException) {
        Get.snackbar('Error', 'Network error: ${e.message}');
      } else {
        Get.snackbar('Error', 'An unexpected error occurred: ${e.toString()}');
      }
      log('Error adding task: $e');
    }
  }

  String _convertPriority(String priority) {
    switch (priority) {
      case 'Low Priority':
        return 'low';
      case 'Medium Priority':
        return 'medium';
      case 'High Priority':
        return 'high';
      default:
        return 'medium';
    }
  }

  void updatePriority(String priority) {
    selectedPriority.value = priority;
  }

  Future<void> uploadImage(File image) async {
    _isUploading.value = true;
    try {
      final String token = LocalStorage.getToken() ?? '';
      final result = await _imageUploadService.uploadImage(image, token);
      if (result != null) {
        _imageUrl.value = result;
        log('Image uploaded successfully. URL: $result');
      } else {
        log('Image upload failed');
        Get.snackbar('Warning',
            'Failed to upload image. You can still create the task without an image.');
      }
    } catch (e) {
      log('Error uploading image: $e');
      Get.snackbar('Error', 'Failed to upload image: ${e.toString()}');
    } finally {
      _isUploading.value = false;
    }
  }

  void updateDueDate(String date) {
    dueDate.value = date;
  }

  getDueDate() {
    return dueDate.value;
  }
}
