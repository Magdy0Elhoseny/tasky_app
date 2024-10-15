import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/core/route/app_route.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';
import 'package:tasky_app/feature/home/view/widgets/custom_appbar.dart';
import 'package:tasky_app/feature/home/view/widgets/task_filter.dart';
import 'package:tasky_app/feature/home/view/widgets/task_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.fetchTasks(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(controller: controller),
                const Text(
                  "My Tasks",
                  style: AppStyels.textStyle16W700,
                ),
                const SizedBox(height: 12),
                HomeScreenFilter(),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return buildTaskList(controller);
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'qr',
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AiBarcodeScanner(
                    onDispose: () {
                      /// This is called when the barcode scanner is disposed.
                      /// You can write your own logic here.
                      debugPrint("Barcode scanner disposed!");
                    },
                    hideGalleryButton: false,
                    controller: MobileScannerController(
                      detectionSpeed: DetectionSpeed.noDuplicates,
                    ),
                    onDetect: (BarcodeCapture capture) {
                      final String? scannedValue =
                          capture.barcodes.first.rawValue;
                      if (scannedValue != null) {
                        // Assuming the scanned value is the task ID
                        Get.toNamed(AppRoutes.details, arguments: scannedValue);
                      }
                    },
                    validator: (value) {
                      if (value.barcodes.isEmpty) {
                        return false;
                      }
                      if (!(value.barcodes.first.rawValue
                              ?.contains('flutter.dev') ??
                          false)) {
                        return false;
                      }
                      return true;
                    },
                  ),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: SvgPicture.asset(AssetManager.qrIcon),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            heroTag: 'addTask',
            onPressed: () {
              controller.goToAddTask();
            },
            backgroundColor: AppStyels.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
