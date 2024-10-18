import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/auth/register/Controller/register_controller.dart';
import 'package:tasky_app/feature/auth/register/view/widgets/error_message_widget.dart';
import 'package:tasky_app/feature/auth/register/view/widgets/input_fields_widget.dart';
import 'package:tasky_app/feature/auth/register/view/widgets/signup_button_widget.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.all(constraints.maxWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: constraints.maxHeight * 0.02),
                        Image.asset(
                          AssetManager.signup,
                          width: double.infinity,
                          height: constraints.maxHeight * 0.25,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.03),
                        const Text(
                          'Sign Up',
                          style: AppStyels.textStyle24W700,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        InputFieldsWidget(
                            controller: controller, constraints: constraints),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        ErrorMessageWidget(controller: controller),
                        SignUpButtonWidget(controller: controller),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        _buildSignInLink(controller),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSignInLink(RegisterController controller) {
    return Center(
      child: GestureDetector(
        onTap: controller.goToSignIn,
        child: RichText(
          text: TextSpan(
            text: "Already have an account? ",
            style: AppStyels.textStyle16W400
                .copyWith(color: AppStyels.textColorSecondary),
            children: [
              TextSpan(
                text: 'Sign In',
                style: AppStyels.textStyle16W400
                    .copyWith(color: AppStyels.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
