import 'package:flutter/material.dart';

class PageDots extends StatelessWidget {
  final int length;
  final int index;
  final Color activeColor;
  final double size;
  final double spacing;

  const PageDots({
    super.key,
    required this.length,
    required this.index,
    required this.activeColor,
    this.size = 8,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(length, (i) {
        final bool active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width: active ? size * 1.8 : size,
          height: size,
          decoration: BoxDecoration(
            color: active ? activeColor : Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: active
                ? [BoxShadow(color: activeColor.withAlpha(100), blurRadius: 10, spreadRadius: 0.5)]
                : null,
          ),
        );
      }),
    );
  }
}