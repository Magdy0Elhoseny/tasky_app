import 'package:flutter/material.dart';

class AppStyels {
  static const Color primaryColor = Color.fromRGBO(95, 51, 225, 1);
  static const Color secondaryColor = Color.fromRGBO(240, 236, 255, 1);
  static const Color accentColor = Color(0xFFE1BEE7);
  static const Color backgroundColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color textColor = Color.fromRGBO(36, 37, 44, 0.6);
  static const Color textColorSecondary = Color(0xFF666666);
  static const Color textfeildColor = Color(0xFF999999);
  static const Color textColorQuaternary = Color(0xFFCCCCCC);

  static ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppStyels.primaryColor),
    scaffoldBackgroundColor: AppStyels.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppStyels.backgroundColor,
    ),
    primaryColor: AppStyels.primaryColor,
  );

  static final textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: AppStyels.primaryColor,
      width: 0.5,
      style: BorderStyle.solid,
    ),
  );

  static const textStyle24W700 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static const textStyle19W700 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 19,
    fontWeight: FontWeight.w700,
  );
  static const textStyle19W500 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 19,
    fontWeight: FontWeight.w500,
  );
  static const textStyle18W700 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static const textStyle16W400 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const textStyle16W500 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const textStyle16W700 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const textStyleHint14W400 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const textStyleHint14W700 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static const textStyleHint14W500 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const textStyleHint12W500 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static const textStyleHint12W400 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static const textStyleHint9W400 = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 9,
    fontWeight: FontWeight.w400,
  );
}
