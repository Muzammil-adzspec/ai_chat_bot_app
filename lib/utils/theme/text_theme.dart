import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/string_constants.dart';

class CustomTextTheme {
  static TextTheme textTheme = const TextTheme(
    labelLarge: TextStyle(
      color: ColorConstants.blackColor,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      fontFamily: StringConstants.font,
    ),
    labelMedium: TextStyle(
      color: ColorConstants.blackColor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: StringConstants.font,
    ),
    labelSmall: TextStyle(
      color: ColorConstants.blackColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: StringConstants.font,
    ),
    displayLarge: TextStyle(
      color: ColorConstants.blackColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: StringConstants.font,
    ),
    // displayMedium: TextStyle(
    //   color: ColorConstants.blackColor,
    //   fontSize: 18,
    //   fontWeight: FontWeight.normal,
    //   fontFamily: StringConstants.poppins,
    // ),
    displaySmall: TextStyle(
      color: ColorConstants.blackColor,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: StringConstants.font,
    ),

    bodyLarge: TextStyle(
      color: ColorConstants.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: StringConstants.font,
    ),
    bodySmall: TextStyle(
      color: ColorConstants.blackColor,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: StringConstants.font,
    ),
    // headlineMedium: TextStyle(
    //   color: blackColor,
    //   fontSize: 16,
    //   fontWeight: FontWeight.bold,
    //   fontFamily: roboto,
    // ),
    // headlineSmall: TextStyle(
    //   color: blackColor,
    //   fontSize: 14,
    //   fontWeight: FontWeight.bold,
    //   fontFamily: roboto,
    // ),
    // titleLarge: TextStyle(
    //   color: blackColor,
    //   fontSize: 14,
    //   fontWeight: FontWeight.normal,
    //   fontFamily: roboto,
    // ),
    // bodyLarge: TextStyle(
    //   color: blackColor,
    //   fontSize: 12,
    //   fontWeight: FontWeight.normal,
    //   fontFamily: roboto,
    // ),
    // bodyMedium: TextStyle(
    //   color: blackColor,
    //   fontSize: 10,
    //   fontWeight: FontWeight.normal,
    //   fontFamily: roboto,
    // ),
  );
}