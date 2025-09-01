import 'package:ai_chat_bot_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/color_constants.dart';
import '../../utils/constants/string_constants.dart';

class CustomTheme {
  static ThemeData primaryTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primaryColor,
      primary: ColorConstants.primaryColor,
      secondary: ColorConstants.whiteColor,
      surfaceTint: ColorConstants.whiteColor,
      shadow: ColorConstants.containerBgColor,
    ),
    useMaterial3: true,
    textTheme: CustomTextTheme.textTheme,
    fontFamily: StringConstants.font,
  );

  // static List<Shadow> textShadow = [
  //   Shadow(
  //     blurRadius: 5,
  //     color: ColorConstants.greyColor.withOpacity(0.3),
  //     offset: const Offset(1, 2),
  //   ),
  // ];

  // static const LinearGradient mainGradient = LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   colors: [
  //     Color(0xffF8DEE2),
  //     Color(0xffE5E2E5),
  //     Color(0xffD3E4E7),
  //     Color(0xff9FECEC),
  //     Color(0xff9FECEC),
  //   ],
  // );
  //
  // static const LinearGradient tealGradient = LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   colors: [
  //     Color(0xff048c7f),
  //     Color(0xff28a99e),
  //   ],
  // );
  //
  // static const LinearGradient fullWhiteGradient = LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   colors: [
  //     ColorConstants.whiteColor,
  //     ColorConstants.whiteColor,
  //   ],
  // );
  //
  // static const LinearGradient middleWhiteGradient = LinearGradient(
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  //   colors: [
  //     Color(0xff28a99e),
  //     Colors.white,
  //     Colors.white,
  //     Color(0xff28a99e),
  //   ],
  // );
  // // 025043
  // // 036c5f
  // // b3e0dc
  //
  // static List<BoxShadow>? containerShadow = [
  //   BoxShadow(
  //     color: ColorConstants.greyColor.withOpacity(.5),
  //     spreadRadius: 3,
  //     blurRadius: 5,
  //     offset: const Offset(4, 6),
  //   ),
  // ];
}