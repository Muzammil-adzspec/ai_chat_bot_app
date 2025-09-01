import 'package:ai_chat_bot_app/utils/constants/local_storage_db.dart';
import 'package:ai_chat_bot_app/utils/globals/global_functions.dart';
import 'package:ai_chat_bot_app/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageDb.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const AIChatBotApp());
}

class AIChatBotApp extends StatelessWidget {
  const AIChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: GlobalFunctions.genericUnFocus,
      child: GetMaterialApp(
        title: 'AI Chat Bot',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: const SplashScreen(),
      ),
    );
  }
}