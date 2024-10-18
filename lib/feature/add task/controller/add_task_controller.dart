import 'dart:io';
import 'package:get/get.dart';
import 'package:tasky_app/core/constants/urls.dart';
import 'package:tasky_app/core/helper/service/add_task_service.dart';
import 'package:tasky_app/core/route/app_route.dart';
import 'package:tasky_app/feature/add%20task/model/add_task_model.dart';

import '../../../core/constants/end_points.dart';

class AddTaskController extends GetxController {
  final AddTaskService _addTaskService = AddTaskService();
  final RxString _imageUrl = RxString('');
  final RxBool _isUploading = RxBool(false);
  final RxString title = RxString('');
  final RxString description = RxString('');
  final RxString dueDate = RxString('');
  final RxString selectedPriority = RxString('Medium Priority');
  final Rx<File?> _pickedImage = Rx<File?>(null);
  File? get pickedImage => _pickedImage.value;

  String get imageUrl => _imageUrl.value;
  bool get isUploading => _isUploading.value;

  bool _validateInputs() {
    if (title.value.isEmpty ||
        description.value.isEmpty ||
        dueDate.value.isEmpty ||
        _pickedImage.value == null) {
      Get.snackbar('Error', 'Please fill all required fields');
      return false;
    }
    return true;
  }

  Future<void> addTask() async {
    if (!_validateInputs()) return;
    String? uploadedImageUrl =
        await _addTaskService.uploadImage(_pickedImage.value!);
    if (uploadedImageUrl == null) {
      Get.snackbar('Error', 'Failed to upload image');
      return;
    }
    final task = AddTaskModel(
      image: "${AppUrls.baseUrl}${EndPoints.images}$uploadedImageUrl",
      title: title.value,
      desc: description.value,
      priority: _convertPriority(selectedPriority.value),
      dueDate: dueDate.value,
    );

    final result = await _addTaskService.addTask(task);
    if (result) {
      Get.snackbar('Success', 'Task added successfully');
      Get.offAllNamed(AppRoutes.home);
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

  void updateDueDate(String date) {
    dueDate.value = date;
  }

  getDueDate() {
    return dueDate.value;
  }

  void setPickedImage(File image) {
    _pickedImage.value = image;
  }
}
