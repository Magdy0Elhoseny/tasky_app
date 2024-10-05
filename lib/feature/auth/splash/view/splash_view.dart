import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/asset manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/auth/splash/Controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: AppStyels.primaryColor,
      body: Center(
        child: Obx(() => AnimatedOpacity(
              opacity: controller.opacity.value,
              duration: const Duration(seconds: 1),
              child: AnimatedScale(
                scale: controller.scale.value,
                duration: const Duration(seconds: 1),
                child: SvgPicture.asset(
                  AssetManager.splashLogosvg,
                  width: 200,
                  height: 200,
                ),
              ),
            )),
      ),
    );
  }
}
