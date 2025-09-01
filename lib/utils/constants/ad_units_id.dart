import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdUnitsId {
  static String get openAppAdUnit {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/9257395921'; // Test ID
    } else {
      return Platform.isAndroid ? 'ca-app-pub-4405033774766390/3010533418' : 'ca-app-pub-4405033774766390/8534322837';
    }
  }

  static String get bannerAdUnit {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Test ID
    } else {
      return Platform.isAndroid ? 'ca-app-pub-4405033774766390/9384370075' : 'ca-app-pub-4405033774766390/5908159499';
    }
  }

  static String get interstitialAdUnitId {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/1033173712'; // Test ID
    } else {
      return Platform.isAndroid ? 'ca-app-pub-4405033774766390/7432978240' : 'ca-app-pub-4405033774766390/2859308414';
    }
  }
}
