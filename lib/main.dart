import 'package:ai_chat_bot_app/utils/constants/local_storage_db.dart';
import 'package:ai_chat_bot_app/utils/globals/global_functions.dart';
import 'package:ai_chat_bot_app/utils/theme/theme.dart';
import 'package:ai_chat_bot_app/view/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        theme: CustomTheme.primaryTheme,
        home: const SplashScreen(),
      ),
    );
  }
}