import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/core/asset manager/asset_manager.dart';
import 'package:tasky_app/feature/add task/controller/add_task_controller.dart';

class AddImageButton extends StatelessWidget {
  final AddTaskController controller = Get.find<AddTaskController>();

  AddImageButton({super.key});

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final File image = File(pickedFile.path);
        controller.setPickedImage(image);
      }
    } catch (e) {
      log('Error picking image: $e');
      Get.snackbar('Error', 'Failed to pick image. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () => _showImageSourceDialog(context),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: AppStyels.primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: controller.pickedImage == null
                ? _buildAddImagePlaceholder()
                : Center(child: _buildPickedImage()),
          ),
        ));
  }

  Widget _buildAddImagePlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetManager.addImageIcon,
              color: AppStyels.primaryColor),
          const SizedBox(height: 8),
          const Text('Add Image',
              style: TextStyle(color: AppStyels.primaryColor)),
        ],
      ),
    );
  }

  Widget _buildPickedImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(controller.pickedImage!, fit: BoxFit.contain),
        ),
      ],
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
