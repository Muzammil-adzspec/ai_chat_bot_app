import 'package:ai_chat_bot_app/utils/extension/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:ai_chat_bot_app/utils/constants/color_constants.dart';
import 'package:ai_chat_bot_app/utils/theme/text_theme.dart';
import 'package:ai_chat_bot_app/utils/generated_assets/assets.dart'; // if you want to use bg
import 'package:ai_chat_bot_app/utils/globals/global_widgets/custom_scaffold.dart';
import 'package:ai_chat_bot_app/utils/globals/global_widgets/glow_pill_button.dart';
import '../../model/on_boarding_slide_model.dart';
import '../../utils/globals/global_widgets/rounded_container_button.dart';
import '../bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'componenets/page_dots.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  final _slides = const <OnboardingSlideModel>[
    OnboardingSlideModel(
      imagePath: Assets.imagesOnBoarding1,
      title: 'Ask AI assistant about\nanything',
      subtitle: 'Nova is capable of responding to any of your questions or needs. Just ask.',
    ),
    OnboardingSlideModel(
      imagePath: Assets.imagesOnBoarding2,
      title: 'Get Help with Writing\nTasks',
      subtitle: 'Ask Nova to write anything and get fast and accurate answers.',
    ),
    OnboardingSlideModel(
      imagePath: Assets.imagesOnBoarding3,
      title: 'Create Images\nwith AI',
      subtitle: 'Generate cool and unique images using only your words.',
    ),
    OnboardingSlideModel(
      imagePath: Assets.imagesOnBoarding1,
      title: 'Chatbots for Different\nNeeds',
      subtitle: 'Chat with Customized Bots, each created for specific use cases.',
    ),
  ];

  bool get _isLast => _index == _slides.length - 1;

  void _next() {
    if (_isLast) {
      context.removeAndUntil(BottomNavBarScreen());
      return;
    }
    _controller.nextPage(duration: const Duration(milliseconds: 280), curve: Curves.easeOut);
  }

  void _skip() {
    print("skipping");
    context.removeAndUntil(BottomNavBarScreen());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bodyPadding: EdgeInsets.zero,
      body: Stack(
        children: [
          // --- Pager + content ---
          Column(
            children: [
              // PAGEVIEW (titles/subtitles)
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _slides.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (_, i) {
                    final s = _slides[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 360,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        ColorConstants.blackColor.withAlpha(30),
                                        ColorConstants.blackColor.withAlpha(0),
                                      ],
                                    ),
                                  ),
                                  child: Image.asset(s.imagePath, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(s.title, textAlign: TextAlign.center, style: context.labelLarge.copyWith(fontSize: 32)),
                          const SizedBox(height: 12),
                          Text(
                            s.subtitle,
                            textAlign: TextAlign.center,
                            style: context.bodyLarge.copyWith(color: Colors.white.withAlpha(220), height: 1.4),
                          ),
                          const Spacer(),
                          PageDots(length: _slides.length, index: _index, activeColor: ColorConstants.primaryColor),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: RoundedContainerButton(
                              label: _isLast ? 'Get Started' : 'Next',
                              onPressed: _next,
                              trailing: const Icon(Icons.arrow_right_alt_rounded, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 12,
            right: 12,
            child: GlowPillButton(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              showGlow: true,
              onTap: () => _skip(),
              child: const Text('Skip'),
            ),
          ),
        ],
      ),
    );
  }
}