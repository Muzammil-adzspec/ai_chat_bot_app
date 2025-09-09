import 'package:ai_chat_bot_app/model/assistant_model.dart';
import 'package:ai_chat_bot_app/utils/constants/color_constants.dart';
import 'package:ai_chat_bot_app/utils/extension/navigation_extension.dart';
import 'package:ai_chat_bot_app/utils/extension/size_extension.dart';
import 'package:ai_chat_bot_app/utils/globals/global_widgets/custom_scaffold.dart';
import 'package:ai_chat_bot_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_chat_bot_app/controller/home_controller.dart';
import 'package:ai_chat_bot_app/utils/globals/global_widgets/premium_plan_banner.dart';
import 'package:ai_chat_bot_app/view/search/search_screen.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                10.w,
                Text("AI Bots", style: context.displayLarge.copyWith(fontWeight: FontWeight.bold)),
                Spacer(),
                _IconCircleButton(icon: Icons.settings, onTap: () {}),
              ],
            ),
            AllBotsList(controller: _homeController),
            PremiumPlanBannerPage(),
            20.h,
            Row(
              children: [
                10.w,
                Text("AI Assistants", style: context.displayLarge.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            20.h,
            AiAssistantsList(),
          ],
        ),
      ),
    );
  }
}

class AiAssistantsList extends StatelessWidget {
  const AiAssistantsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: assistants.length,
      itemBuilder: (context, index) {
        final a = assistants[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            onTap: () => context.push(SearchScreen(assistantType: a.type)),
            tileColor: ColorConstants.darkGreyColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(a.name, style: context.bodyLarge),
            subtitle: Text(a.description, style: context.bodySmall.copyWith(color: ColorConstants.lightGreyColor)),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstants.blackColor),
              child: Image.asset(a.iconPath, height: 40, width: 40),
            ),
            trailing: ChatButton(),
          ),
        );
      },
      separatorBuilder: (context, index) {
        // yeh separator item[index] aur item[index+1] ke beech aata hai
        // har 5 items ke baad banner dikhao (i.e., after indices 4, 9, 14, ...)
        if ((index + 1) % 5 == 0) {
          return Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: PremiumPlanBannerPage());
        }
        // warna normal spacing
        return const SizedBox.shrink();
      },
    );
  }
}

class AllBotsList extends StatelessWidget {
  final HomeController controller;
  const AllBotsList({super.key, required this.controller});

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
            onTap: () {
              // Handle assistant tile tap
            },
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
            trailing: ChatButton(),
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

class ChatButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ChatButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: ColorConstants.primaryDarkColor.withAlpha(180),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorConstants.primaryColor.withAlpha(217), width: 2),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.primaryColor.withAlpha(89),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          child: Text(
            "Chat",
            style: context.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}