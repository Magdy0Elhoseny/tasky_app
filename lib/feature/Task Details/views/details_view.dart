import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/Task%20Details/controller/details_controller.dart';
import 'package:tasky_app/feature/Task%20Details/views/widgets/status_details_dropdown.dart';
import 'package:tasky_app/feature/Task%20Details/views/widgets/priority_details_dropdown.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        titleTextStyle: AppStyels.textStyle16W700.copyWith(color: Colors.black),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: AppStyels.backgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(AssetManager.arrowBackIcon),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              if (value == 'edit') {
                controller.editTask();
              } else if (value == 'delete') {
                controller.deleteTask();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.black),
                    const SizedBox(width: 8),
                    Text('Save Edit', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    const SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            offset: Offset(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: Colors.white,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        DateTime createdAtDate =
            DateTime.parse(controller.task.value!.createdAt);
        String formattedDate = DateFormat('dd MMM, yyyy').format(createdAtDate);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.task.value!.image.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    controller.task.value!.image,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              const SizedBox(height: 16),
              Text(controller.task.value!.title,
                  style: AppStyels.textStyle24W700),
              const SizedBox(height: 8),
              Text(
                controller.task.value!.desc,
                style: AppStyels.textStyleHint14W400
                    .copyWith(color: AppStyels.textfeildColor),
              ),
              const SizedBox(height: 16),
              _buildInfoCard('End Date', formattedDate, Icons.calendar_today),
              const SizedBox(height: 8),
              const StatusDetailsDropdown(),
              const SizedBox(height: 8),
              const PriorityDetailsDropdown(),
              const SizedBox(height: 24),
              Center(
                child: QrImageView(
                  data: controller.task.value?.id ?? '',
                  version: QrVersions.auto,
                  size: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyels.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 7, bottom: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: AppStyels.textStyleHint9W400
                          .copyWith(color: AppStyels.textfeildColor)),
                  const SizedBox(height: 4),
                  Text(value,
                      style: AppStyels.textStyleHint14W400
                          .copyWith(color: Color.fromRGBO(36, 37, 44, 1))),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(AssetManager.calendarIcon),
          ),
        ],
      ),
    );
  }
}
