import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import '../enums/assistant_type.dart';

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

class GeminiHttpClient {
  final http.Client _client;
  GeminiHttpClient([http.Client? c]) : _client = c ?? http.Client();

  // ---- Build request body for a given assistant ----
  Map<String, dynamic> _body(String userText, AssistantType type) {
    return {
      "systemInstruction": {
        "role": "system",
        "parts": [
          {"text": assistantSystem(type)},
        ],
      },
      "generationConfig": {"temperature": 0.6, "maxOutputTokens": 1024},
      // If you want safetySettings, add here
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": userText},
          ],
        },
      ],
    };
  }

  /// --------- NON-STREAM ----------
  Future<String> generate(String userText, AssistantType type) async {
    final uri = Uri.parse(StringConstants.genUrl());
    final res = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(_body(userText, type)),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final json = jsonDecode(res.body) as Map<String, dynamic>;
      // gemini v1beta returns candidates[0].content.parts[].text
      final candidates = (json['candidates'] as List?) ?? [];
      if (candidates.isEmpty) return '';
      final parts = (((candidates.first as Map)['content'] as Map)['parts'] as List?) ?? [];
      final buf = StringBuffer();
      for (final p in parts) {
        final t = (p as Map)['text'] as String?;
        if (t != null) buf.write(t);
      }
      return buf.toString();
    } else {
      throw Exception('Gemini error ${res.statusCode}: ${res.body}');
    }
  }

  /// --------- STREAM (SSE) ----------
  /// Progressive text: yields the concatenated text so far.
  Stream<String> generateStream(String userText, AssistantType type) async* {
    final req = http.Request('POST', Uri.parse(StringConstants.sseUrl()))
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode(_body(userText, type));

    final streamed = await _client.send(req);
    if (streamed.statusCode < 200 || streamed.statusCode >= 300) {
      final body = await streamed.stream.bytesToString();
      throw Exception('Gemini SSE error ${streamed.statusCode}: $body');
    }

    final buffer = StringBuffer();

    // SSE comes as "data: {json}\n\n"
    await for (final chunk in streamed.stream.transform(utf8.decoder)) {
      for (final line in const LineSplitter().convert(chunk)) {
        if (!line.startsWith('data:')) continue;
        final payload = line.substring(5).trim(); // after 'data:'
        if (payload.isEmpty || payload == '[DONE]') continue;

        try {
          final json = jsonDecode(payload) as Map<String, dynamic>;
          final cands = (json['candidates'] as List?) ?? [];
          if (cands.isEmpty) continue;
          final parts = (((cands.first as Map)['content'] as Map)['parts'] as List?) ?? [];
          // Each SSE event can include partial text in parts[].text
          for (final p in parts) {
            final t = (p as Map)['text'] as String?;
            if (t != null && t.isNotEmpty) {
              buffer.write(t);
              yield buffer.toString();
            }
          }
        } catch (_) {
          // ignore malformed event lines
        }
      }
    }
  }

  void dispose() => _client.close();
}