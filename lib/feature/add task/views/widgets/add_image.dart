import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
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
      Get.snackbar('Error', 'Failed to pick image. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () => _showImageSourceDialog(context),
          child: controller.pickedImage == null
              ? _buildAddImagePlaceholder()
              : Center(child: _buildPickedImage()),
        ));
  }

  Widget _buildAddImagePlaceholder() {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: DottedBorder(
          borderType: BorderType.RRect,
          strokeCap: StrokeCap.round,
          color: AppStyels.primaryColor,
          dashPattern: const [1.6, 4],
          radius: const Radius.circular(12),
          strokeWidth: 1.2,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  color: AppStyels.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Add Image',
                  style: AppStyels.textStyle16W700
                      .copyWith(color: AppStyels.primaryColor),
                )
              ],
            ),
          )),
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
