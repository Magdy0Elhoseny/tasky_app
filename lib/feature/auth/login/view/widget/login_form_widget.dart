import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/Ui/custom_button.dart';
import 'package:tasky_app/core/helper/Ui/custom_text_field.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/auth/login/Controller/login_controller.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key, required this.controller});
  final LoginController controller;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Login',
          style: AppStyels.textStyle24W700,
        ),
        const SizedBox(height: 24),
        CustomTextFormField(
          maxLength: 10,
          controller: widget.controller.phoneController,
          hintText: '1142297381',
          keyboardType: TextInputType.phone,
          prefixIcon: CountryCodePicker(
            initialSelection: 'EG',
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            favorite: const ['+20', 'EG'],
            onChanged: (countryCode) {
              widget.controller
                  .updateCountryCode(countryCode.dialCode ?? '+20');
            },
          ),
        ),
        const SizedBox(height: 16),
        Obx(() => CustomTextFormField(
              hintText: 'Password...',
              controller: widget.controller.passwordController,
              obscureText: widget.controller.isPasswordHidden.value,
              suffixIcon: IconButton(
                icon: Icon(
                  widget.controller.isPasswordHidden.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: widget.controller.togglePasswordVisibility,
              ),
            )),
        const SizedBox(height: 24),
        Obx(() => widget.controller.errorMessage.value.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  widget.controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            : const SizedBox.shrink()),
        Obx(() => widget.controller.isLoading.value
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                child: CustomButton(
                  backgroundColor: AppStyels.primaryColor,
                  textColor: Colors.white,
                  onPressed: widget.controller.signIn,
                  borderRadius: BorderRadius.circular(12),
                  buttonChild: Text(
                    'Sign In',
                    style:
                        AppStyels.textStyle19W700.copyWith(color: Colors.white),
                  ),
                ),
              )),
        const SizedBox(height: 16),
        Center(
          child: GestureDetector(
            onTap: widget.controller.goToSignUp,
            child: RichText(
              text: TextSpan(
                text: "Didn't have any account? ",
                style: AppStyels.textStyle16W400
                    .copyWith(color: AppStyels.textColorSecondary),
                children: [
                  TextSpan(
                    text: 'Sign Up here',
                    style: AppStyels.textStyle16W400
                        .copyWith(color: AppStyels.primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
