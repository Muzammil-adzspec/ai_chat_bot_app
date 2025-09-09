import 'package:ai_chat_bot_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:ai_chat_bot_app/utils/constants/color_constants.dart';

class GlowPillButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final double borderWidth;
  final double? width;
  final Color? fillColor;
  final Color? borderColor;
  final bool showGlow;

  const GlowPillButton({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.radius = 14,
    this.borderWidth = 1.2,
    this.fillColor,
    this.borderColor,
    this.showGlow = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final c = borderColor ?? ColorConstants.primaryColor;
    final bgBase = fillColor ?? ColorConstants.blackColor;

    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: bgBase.withAlpha(180), // ~0.22
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: c.withAlpha(217), width: borderWidth), // ~0.85
            boxShadow: showGlow
                ? [
                    BoxShadow(
                      color: c.withAlpha(89), // ~0.35
                      blurRadius: 18,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Center(
                  child: DefaultTextStyle.merge(style: context.displaySmall, child: child),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}