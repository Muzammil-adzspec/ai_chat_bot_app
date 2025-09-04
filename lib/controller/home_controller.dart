import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../utils/generated_assets/assets.dart';

class BotTileModel {
  final String title;
  final String asset;
  final Color ring;
  const BotTileModel(this.title, this.asset, this.ring);
}

class HomeController extends GetxController {
  // Static data for bots; load from API later if needed
  final bots = const <BotTileModel>[
    BotTileModel('OpenAI GPT-4', Assets.iconsChatGpt, Color(0xFF00FF9A)),
    BotTileModel('OpenAI GPT-4o', Assets.iconsChatGpt, Color(0xFF00FF9A)),
    BotTileModel('DeepSeek R1', Assets.iconsDeepSeek, Color(0xFF3DA4FF)),
    // BotTileModel('Claude 3.5 Sonnet', 'assets/bots/claude.png', Color(0xFFFF7A45)),
    // BotTileModel('Voice Chat', 'assets/bots/voice.png', Color(0xFF8E5BFF)),
    // BotTileModel('Web Search', 'assets/bots/search.png', Colors.white),
    // BotTileModel('Image Generator', 'assets/bots/image.png', Color(0xFF00FF9A)),
    BotTileModel('Google Gemini', Assets.iconsGemini, Color(0xFF63A4FF)),
  ];
}