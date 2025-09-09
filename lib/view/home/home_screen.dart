import 'package:ai_chat_bot_app/utils/extension/navigation_extension.dart';
import 'package:ai_chat_bot_app/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_chat_bot_app/utils/constants/color_constants.dart';
import 'package:ai_chat_bot_app/utils/theme/text_theme.dart';
import 'package:ai_chat_bot_app/utils/globals/global_widgets/custom_scaffold.dart';
import '../../controller/bottom_nav_controller.dart';
import '../../controller/home_controller.dart';
import '../../utils/enums/assistant_type.dart';
import '../../utils/generated_assets/assets.dart';
import '../../utils/globals/global_functions.dart';
import '../../utils/globals/global_widgets/ai_logo_with_glow_bg.dart';
import '../../utils/globals/global_widgets/premium_plan_banner.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeC = Get.put(HomeController());
  final BottomNavController navC = Get.put(BottomNavController());

  @override
  void dispose() {
    Get.delete<HomeController>();
    Get.delete<BottomNavController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          // Content
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ===== center logo (you will replace) =====
                      AiLogoWithGlowBg(),
                      10.h,
                      // ===== search tap area (non-editable) =====
                      _SearchTap(
                        onTap: () {
                          context.push(SearchScreen(assistantType: AssistantType.generic));
                        },
                      ),
                      16.h,
                      Text('My Bots', style: context.labelSmall),
                      12.h,
                      _BotsGrid(controllerTag: homeC),
                      8.h,
                      // ===== premium card placeholder =====
                      PremiumPlanBannerPage(),
                      90.h, // space for bottom bar notch
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 12,
            right: 12,
            child: _IconCircleButton(icon: Icons.settings, onTap: () {}),
          ),
          // Credits pill (top-left)
          // Positioned(top: 12, left: 12, child: _CreditsPill(count: 3, onTap: () {})),
        ],
      ),
    );
  }
}

class _SearchTap extends StatelessWidget {
  final VoidCallback onTap;
  const _SearchTap({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final border = ColorConstants.primaryColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: ColorConstants.darkGreyColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: border.withAlpha(200), width: 1.2),
          boxShadow: [
            BoxShadow(color: border.withAlpha(80), blurRadius: 25, spreadRadius: 5, offset: const Offset(0, 1)),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text('Ask a question…', style: context.displaySmall.copyWith(color: Colors.white.withAlpha(200))),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.camera_alt, color: ColorConstants.primaryColor, size: 25),
            ),
          ],
        ),
      ),
    );
  }
}

class _BotsGrid extends StatelessWidget {
  final HomeController controllerTag;
  const _BotsGrid({required this.controllerTag});

  @override
  Widget build(BuildContext context) {
    final bots = controllerTag.bots;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: bots.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        mainAxisExtent: 120,
      ),
      itemBuilder: (_, i) {
        final b = bots[i];
        return _BotTile(title: b.title, asset: b.asset, ring: b.ring, onTap: () => {});
      },
    );
  }
}

class _BotTile extends StatelessWidget {
  final String title;
  final String asset;
  final Color ring;
  final VoidCallback onTap;

  const _BotTile({required this.title, required this.asset, required this.ring, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 62,
            width: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withAlpha(70),
              // boxShadow: [BoxShadow(color: ring.withAlpha(100), blurRadius: 14, spreadRadius: 1)],
              border: Border.all(color: ring.withAlpha(220), width: 1.4),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(asset, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _IconCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconCircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorConstants.containerBgColor.withAlpha(40),
          shape: BoxShape.circle,
          border: Border.all(color: ColorConstants.primaryColor.withAlpha(210), width: 1.2),
        ),
        child: const Icon(Icons.settings, size: 18, color: Colors.white),
      ),
    );
  }
}

class _CreditsPill extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  const _CreditsPill({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.primaryColor;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: ColorConstants.containerBgColor.withAlpha(40),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: c.withAlpha(210), width: 1.2),
        ),
        child: Row(
          children: [
            const Icon(Icons.auto_awesome_sharp, size: 20, color: Colors.white),
            6.w,
            Text('$count', style: context.displaySmall),
          ],
        ),
      ),
    );
  }
}