import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/Ui/custom_text_field.dart';
import 'package:tasky_app/feature/auth/register/Controller/register_controller.dart';

Widget buildInputFields(
    RegisterController controller, BoxConstraints constraints) {
  return Column(
    children: [
      CustomTextFormField(
        controller: controller.nameController,
        hintText: 'Name...',
      ),
      SizedBox(height: constraints.maxHeight * 0.02),
      CustomTextFormField(
        maxLength: 10,
        controller: controller.phoneController,
        hintText: '123 456-7890',
        keyboardType: TextInputType.phone,
        prefixIcon: CountryCodePicker(
          initialSelection: 'EG',
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
          favorite: const ['+20', 'EG'],
          onChanged: (countryCode) {
            controller.updateCountryCode(countryCode.dialCode ?? '+20');
          },
        ),
      ),
      SizedBox(height: constraints.maxHeight * 0.02),
      CustomTextFormField(
        controller: controller.experienceYearsController,
        hintText: 'Years of experience...',
        keyboardType: TextInputType.number,
      ),
      SizedBox(height: constraints.maxHeight * 0.02),
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: 'Choose experience Level',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        value: controller.selectedExperienceLevel.value,
        onChanged: controller.updateExperienceLevel,
        items: ['junior', 'mid-level', 'senior']
            .map((level) => DropdownMenuItem(
                  value: level,
                  child: Text(level.capitalize!),
                ))
            .toList(),
      ),
      SizedBox(height: constraints.maxHeight * 0.02),
      CustomTextFormField(
        controller: controller.addressController,
        hintText: 'Address...',
      ),
      SizedBox(height: constraints.maxHeight * 0.02),
      Obx(() => CustomTextFormField(
            hintText: 'Password...',
            controller: controller.passwordController,
            obscureText: controller.isPasswordHidden.value,
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordHidden.value
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: controller.togglePasswordVisibility,
            ),
          )),
    ],
  );
}
