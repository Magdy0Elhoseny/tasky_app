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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task Details', style: AppStyels.textStyle16W700),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset(AssetManager.arrowBackIcon),
          ),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('SaveEdit', style: AppStyels.textStyle16W500),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(
                    'Delete',
                    style: AppStyels.textStyle16W500.copyWith(
                      color: const Color.fromRGBO(255, 125, 83, 1),
                    ),
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'edit') {
                  controller.editTask();
                } else if (value == 'delete') {
                  // controller.deleteTask();
                }
              },
            ),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          // final DetailsTaskModel task = controller.task.value!;
          DateTime createdAtDate =
              DateTime.parse(controller.task.value!.createdAt);
          String formattedDate = DateFormat('dd-MM-yyyy').format(createdAtDate);
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
                      height: 200,
                      fit: BoxFit.cover,
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
                const PriorityDetailsDropdown(),
                const SizedBox(height: 8),
                const StatusDetailsDropdown(),
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
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppStyels.secondaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppStyels.primaryColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppStyels.textStyleHint12W500),
                const SizedBox(height: 4),
                Text(value, style: AppStyels.textStyle16W500),
              ],
            ),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
