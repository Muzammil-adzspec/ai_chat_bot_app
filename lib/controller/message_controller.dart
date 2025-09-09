// lib/features/chat/message_controller.dart
import 'package:get/get.dart';

import '../utils/enums/assistant_type.dart';
import '../utils/globals/global_functions.dart';

class ChatMsg {
  final bool fromUser;
  final String text;
  ChatMsg(this.fromUser, this.text);
}

class MessageController extends GetxController {
  final messages = <ChatMsg>[].obs;
  final GeminiHttpClient _api = GeminiHttpClient();

  @override
  void onClose() {
    _api.dispose();
    super.onClose();
  }

  Future<void> send({required String text, required AssistantType who}) async {
    if (text.trim().isEmpty) return;
    messages.add(ChatMsg(true, text));

    // streaming typewriter effect
    String acc = '';
    messages.add(ChatMsg(false, '')); // placeholder
    final botIdx = messages.length - 1;

    await for (final partial in _api.generateStream(text, who)) {
      acc = partial;
      messages[botIdx] = ChatMsg(false, acc);
      print("messages: ${messages.last.text}");
      messages.refresh();
    }
  }
}