import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/core/route/app_route.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';

class FloatingActionsButtons extends StatelessWidget {
  const FloatingActionsButtons({super.key, required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: FloatingActionButton(
            heroTag: 'qr',
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AiBarcodeScanner(
                    onDispose: () {
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
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: SvgPicture.asset(
              AssetManager.qrIcon,
              width: 24,
              height: 24,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 64,
          width: 64,
          child: FloatingActionButton(
            heroTag: 'addTask',
            elevation: 0,
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
        ),
      ],
    );
  }
}
