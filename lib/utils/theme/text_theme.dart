import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/string_constants.dart';

extension CustomTextThemeContext on BuildContext {
  ThemeData get appTheme => Theme.of(this);

  TextTheme get textTheme => appTheme.textTheme;

  TextStyle get displayLarge => textTheme.displayLarge!;

  // TextStyle get displayMedium => textTheme.displayMedium!;

  TextStyle get displaySmall => textTheme.displaySmall!;

  TextStyle get labelLarge => textTheme.labelLarge!;

  TextStyle get labelMedium => textTheme.labelMedium!;

  TextStyle get labelSmall => textTheme.labelSmall!;

  TextStyle get bodySmall => textTheme.bodySmall!;

  TextStyle get bodyLarge => textTheme.bodyLarge!;
}

class CustomTextTheme {
  static TextTheme textTheme = const TextTheme(
    labelLarge: TextStyle(
      color: ColorConstants.whiteColor,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      fontFamily: StringConstants.font,
    ),
    labelMedium: TextStyle(
      color: ColorConstants.whiteColor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: StringConstants.font,
    ),
    labelSmall: TextStyle(
      color: ColorConstants.whiteColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: StringConstants.font,
    ),
    displayLarge: TextStyle(
      color: ColorConstants.whiteColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: StringConstants.font,
    ),
    // displayMedium: TextStyle(
    //   color: ColorConstants.whiteColor,
    //   fontSize: 18,
    //   fontWeight: FontWeight.normal,
    //   fontFamily: StringConstants.poppins,
    // ),
    displaySmall: TextStyle(
      color: ColorConstants.whiteColor,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: StringConstants.font,
    ),

    bodyLarge: TextStyle(
      color: ColorConstants.whiteColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: StringConstants.font,
    ),
    bodySmall: TextStyle(
      color: ColorConstants.whiteColor,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: StringConstants.font,
    ),
    // headlineMedium: TextStyle(
    //   color: whiteColor,
    //   fontSize: 16,
    //   fontWeight: FontWeight.bold,
    //   fontFamily: roboto,
    // ),
    // headlineSmall: TextStyle(
    //   color: whiteColor,
    //   fontSize: 14,
    //   fontWeight: FontWeight.bold,
    //   fontFamily: roboto,
    // ),
    // titleLarge: TextStyle(
    //   color: whiteColor,
    //   fontSize: 14,
    //   fontWeight: FontWeight.normal,
    //   fontFamily: roboto,
    // ),
    // bodyLarge: TextStyle(
    //   color: whiteColor,
    //   fontSize: 12,
    //   fontWeight: FontWeight.normal,
    //   fontFamily: roboto,
    // ),
    // bodyMedium: TextStyle(
    //   color: whiteColor,
    //   fontSize: 10,
    //   fontWeight: FontWeight.normal,
    //   fontFamily: roboto,
    // ),
  );
}