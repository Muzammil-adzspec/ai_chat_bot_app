import 'package:ai_chat_bot_app/utils/constants/color_constants.dart';
import 'package:ai_chat_bot_app/utils/extension/navigation_extension.dart';
import 'package:ai_chat_bot_app/utils/generated_assets/assets.dart';
import 'package:ai_chat_bot_app/utils/extension/size_extension.dart';
import 'package:ai_chat_bot_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import '../../utils/globals/global_widgets/custom_scaffold.dart';
import '../../utils/globals/global_widgets/glow_pill_button.dart';
import '../on_boarding/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      context.removeAndUntil(OnboardingScreen());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: SizedBox(
          height: 100,
          child: Center(
            child: Column(
              children: [
                Text("Developed on", style: context.displaySmall),
                10.h,
                GlowPillButton(onTap: () {}, child: Text('GPT-5 & DeepSeek')),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Inner radial gradient disc (fades BEFORE the edge)
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // Tip: transparent at stop < 1.0 to avoid hard rim
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.6,
                  colors: [
                    ColorConstants.primaryColor.withAlpha(140), // bright center
                    Colors.transparent, // fully faded before edge
                  ],
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),

            // Logo
            SizedBox(height: 120, width: 120, child: Image.asset(Assets.iconsLogo)),
          ],
        ),
      ),
    );
  }
}