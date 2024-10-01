import 'package:flutter/material.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.backgroundColor,
    required this.textColor,
    this.borderRadius,
    this.text,
    this.fontSize,
    this.onPressed,
    this.buttonWidth,
    this.height,
    this.buttonChild,
  });
  final String? text;
  final Color backgroundColor;
  final Color textColor;
  final BorderRadius? borderRadius;
  final double? fontSize;
  final double? height;
  final double? buttonWidth;
  final void Function()? onPressed;
  final Widget? buttonChild;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 49,
      width: buttonWidth ?? 200,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: buttonChild ??
            Text(
              text!,
              style: AppStyels.textStyle19W700.copyWith(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
      ),
    );
  }
}
