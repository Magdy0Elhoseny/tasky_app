import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      this.maxLines = 1,
      this.onSaved,
      this.onChanged,
      this.maxLength,
      this.keyboardType,
      this.style,
      this.hintSize,
      this.controller,
      this.obscureText,
      this.suffixIcon,
      this.prefixIcon});
  final String hintText;
  final double? hintSize;
  final int maxLines;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final TextEditingController? controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      keyboardType: keyboardType,
      selectionWidthStyle: BoxWidthStyle.tight,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'This field is required';
        } else {
          return null;
        }
      },
      cursorColor: AppStyels.textfeildColor,
      maxLines: maxLines,
      style: style ?? AppStyels.textStyleHint14W400,
      textAlign: TextAlign.start,
      maxLength: maxLength ?? 30,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        counterText: "",
        hintText: hintText,
        hintStyle: AppStyels.textStyleHint14W400.copyWith(
          color: AppStyels.textfeildColor,
        ),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(AppStyels.primaryColor),
      ),
    );
  }

  OutlineInputBorder buildBorder([colorBorder]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: colorBorder ?? Colors.grey,
      ),
    );
  }
}
