import 'package:ai_chat_bot_app/utils/constants/color_constants.dart';
import 'package:ai_chat_bot_app/utils/extension/size_extension.dart';
import 'package:ai_chat_bot_app/utils/globals/global_widgets/custom_scaffold.dart';
import 'package:ai_chat_bot_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_chat_bot_app/controller/home_controller.dart';
import 'package:ai_chat_bot_app/utils/globals/global_widgets/premium_plan_banner.dart';

class AllBotsScreen extends StatefulWidget {
  const AllBotsScreen({super.key});

  @override
  State<AllBotsScreen> createState() => _AllBotsScreenState();
}

class _AllBotsScreenState extends State<AllBotsScreen> {
  final HomeController _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Row(
            children: [
              10.w,
              Text("AI Bots", style: context.displayLarge.copyWith(fontWeight: FontWeight.bold)),
              Spacer(),
              _IconCircleButton(
                icon: Icons.settings,
                onTap: () {
                  print("abc");
                },
              ),
            ],
          ),
          _BotsGrid(controller: _homeController),
          PremiumPlanBannerPage(),
        ],
      ),
    );
  }
}

class _BotsGrid extends StatelessWidget {
  final HomeController controller;
  const _BotsGrid({required this.controller});

  @override
  Widget build(BuildContext context) {
    final bots = controller.bots;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: bots.length,
      itemBuilder: (_, i) {
        final BotTileModel b = bots[i];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            tileColor: ColorConstants.darkGreyColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.blackColor,
                border: Border.all(color: b.ring, width: 2),
              ),
              child: Image.asset(b.asset, height: 40, width: 40),
            ),
            title: Text(b.title, style: context.bodyLarge),
            subtitle: Text(
              'Lorem ipsum is a dummy or placeholder text commonly',
              style: context.bodySmall.copyWith(color: ColorConstants.lightGreyColor),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.white),
            onTap: () {
              // Handle bot tile tap
            },
          ),
        );
      },
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