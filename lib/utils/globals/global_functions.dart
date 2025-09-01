import 'dart:async';
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/color_constants.dart';

class GlobalFunctions {
  static void genericUnFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<void> logFirebaseEvent({required String screenName}) async {
    if (!kDebugMode) {
      unawaited(FirebaseAnalytics.instance.logEvent(name: screenName));
    }
  }

  static Future<XFile?> pickImage(ImageSource source) async {
    return await ImagePicker().pickImage(source: source);
  }

  // static Future<void> shareText({required String text}) async {
  //   await SharePlus.instance.share(ShareParams(text: text));
  // }

  static Future<void> launchURLInBrowser({required String url}) async {
    Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }

  static Future<bool> hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 2));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint("Internet Available");
        return true;
      }
      debugPrint("Internet not Available");
      return false;
    } on SocketException catch (_) {
      debugPrint("Internet not Available Socket Exception");
      return false;
    } on TimeoutException {
      debugPrint("Internet not Available Timeout Exception");

      return false;
    }
  }

  static Future<void> safeDelete(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint("Error deleting temp file: $e");
    }
  }

  static void showErrorSnackBar({String title = "Invalid Image", required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorConstants.whiteColor,
      colorText: Colors.red,
      duration: Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      borderColor: Colors.red,
      borderWidth: 1.0,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  static void showSuccessSnackBar({String title = "Success", required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: ColorConstants.whiteColor,
      colorText: ColorConstants.primaryColor,
      duration: Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      borderColor: ColorConstants.primaryColor,
      borderWidth: 1.0,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}