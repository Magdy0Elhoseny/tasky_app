import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/Ui/custom_button.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/auth/onborading/Controller/onboarding_controller.dart';

import '../../../../core/asset manager/asset_manager.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.put(OnboardingController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                AssetManager.onbording,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Task Management & To-Do List',
                      style: AppStyels.textStyle24W700
                          .copyWith(color: AppStyels.textColor),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'This productive tool is designed to help you better manage your task project-wise conveniently!',
                      style: AppStyels.textStyle16W400
                          .copyWith(color: AppStyels.textColorSecondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        backgroundColor: AppStyels.primaryColor,
                        textColor: Theme.of(context).scaffoldBackgroundColor,
                        onPressed: controller.onGetStarted,
                        borderRadius: BorderRadius.circular(12),
                        buttonChild: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Let's Start",
                              style: AppStyels.textStyle19W700
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            SvgPicture.asset(
                              AssetManager.letsStartArrowIcon,
                              width: 24,
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                      // ElevatedButton(

                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: AppStyels.primaryColor,
                      //     padding: const EdgeInsets.symmetric(vertical: 16),

                      //   ),
                      //   child:
                      // ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
