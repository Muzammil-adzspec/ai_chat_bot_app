import 'package:flutter/material.dart';
import 'package:ai_chat_bot_app/utils/constants/color_constants.dart';
import 'package:ai_chat_bot_app/utils/theme/text_theme.dart';

class RoundedContainerButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final double radius;

  const RoundedContainerButton({
    super.key,
    required this.label,
    this.onPressed,
    this.leading,
    this.trailing,
    this.radius = 14,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primaryColor,
          shadowColor: ColorConstants.primaryColor.withAlpha(120),
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            leading != null
                ? Padding(padding: const EdgeInsets.only(left: 10.0), child: leading!)
                : const SizedBox.shrink(),
            Text(label, style: context.labelSmall),
            trailing != null
                ? Padding(padding: const EdgeInsets.only(right: 10.0), child: trailing!)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}