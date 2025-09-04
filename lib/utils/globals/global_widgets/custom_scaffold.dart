import 'package:flutter/material.dart';
import 'package:ai_chat_bot_app/utils/generated_assets/assets.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry? bodyPadding;

  const CustomScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.bodyPadding,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage(Assets.imagesScaffoldBg), fit: BoxFit.cover),
      ),
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          appBar: appBar,
          body: Padding(padding: bodyPadding ?? EdgeInsets.symmetric(horizontal: 10.0), child: body),
          bottomNavigationBar: bottomNavigationBar,
          backgroundColor: Colors.transparent,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }
}