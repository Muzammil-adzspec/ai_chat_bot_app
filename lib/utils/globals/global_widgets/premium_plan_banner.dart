import 'dart:async';

import 'package:ai_chat_bot_app/utils/extension/size_extension.dart';
import 'package:ai_chat_bot_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import '../../generated_assets/assets.dart';

class PremiumPlanBannerPage extends StatefulWidget {
  const PremiumPlanBannerPage({super.key, this.height = 120, this.autoRotate = true});

  final double height;
  final bool autoRotate;

  @override
  State<PremiumPlanBannerPage> createState() => _PremiumPlanBannerPageState();
}

class _PremiumPlanBannerPageState extends State<PremiumPlanBannerPage> {
  late final PageController _pc;
  Timer? _ticker;
  int _index = 0; // 0: Yearly ($50), 1: Monthly ($5)

  @override
  void initState() {
    super.initState();
    _pc = PageController(initialPage: _index);

    if (widget.autoRotate) {
      _ticker = Timer.periodic(const Duration(seconds: 5), (_) {
        if (!mounted) return;
        _index = (_index + 1) % 2;
        _pc.animateToPage(_index, duration: const Duration(milliseconds: 350), curve: Curves.easeOutCubic);
      });
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _pc.dispose();
    super.dispose();
  }

  void _goToSubscriptionFor(int index) {
    // map: 0 -> Yearly ($50, planId 0), 1 -> Monthly ($5, planId 1)
    // final planId = index == 1 ? 1 : 0;
    // Get.find<SubscriptionController>().setSelectedPlan(planId);
    // // navigate
    // context.push(SubscriptionScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: PageView(
        controller: _pc,
        onPageChanged: (i) => _index = i,
        children: [
          // Page 0: Yearly
          PremiumPlanBanner(buttonText: "\$50 USD / Year", onTap: () => _goToSubscriptionFor(0)),
          // Page 1: Monthly
          PremiumPlanBanner(buttonText: "\$4.99 USD / Month", onTap: () => _goToSubscriptionFor(1)),
        ],
      ),
    );
  }
}

class PremiumPlanBanner extends StatelessWidget {
  const PremiumPlanBanner({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.title = "Go Premium & Track\nSmarter",
    this.height = 130,
  });

  final String title;
  final String buttonText;
  final VoidCallback onTap;

  final double height;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18);

    return ClipRRect(
      borderRadius: radius,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          // color: ColorConstants.primaryColor,
          image: DecorationImage(image: AssetImage(Assets.imagesPremiumBannerBg), fit: BoxFit.cover),
          boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, 3))],
        ),
        child: Stack(
          children: [
            // Right side orange swirl background
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  // width: height, // circle size ~ card height
                  // height: height,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // gradient: RadialGradient(
                    //   colors: [gradientStart, gradientEnd],
                    //   center: Alignment.center,
                    //   radius: 0.85,
                    // ),
                  ),
                  child: Image.asset(Assets.imagesPremiumAiBot, fit: BoxFit.fitHeight),
                ),
              ),
            ),
            // Content row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  // Left: text + button
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        10.h,
                        Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.displayLarge),
                        // const Spacer(),
                        10.h,
                        // Price pill
                        _PricePill(text: buttonText, onTap: onTap, textColor: Colors.white),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PricePill extends StatelessWidget {
  const _PricePill({required this.text, required this.onTap, this.textColor = Colors.white});

  final String text;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: ColorConstants.primaryDarkColor,
          border: Border.all(color: ColorConstants.primaryColor, width: 1.2),
          // gradient: const LinearGradient(
          //   colors: [ColorConstants.blueColor, ColorConstants.primaryColor],
          //   begin: Alignment.centerLeft,
          //   end: Alignment.centerRight,
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor, fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}