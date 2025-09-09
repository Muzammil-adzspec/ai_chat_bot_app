import 'package:ai_chat_bot_app/utils/extension/navigation_extension.dart';
import 'package:ai_chat_bot_app/utils/globals/global_functions.dart';
import 'package:ai_chat_bot_app/view/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_chat_bot_app/utils/globals/global_widgets/custom_scaffold.dart';
import 'package:ai_chat_bot_app/utils/constants/color_constants.dart';
import 'package:ai_chat_bot_app/utils/theme/text_theme.dart';
import 'package:ai_chat_bot_app/utils/extension/size_extension.dart';
import 'package:ai_chat_bot_app/utils/generated_assets/assets.dart';
import '../../controller/inbox_controller.dart';
import '../../utils/enums/assistant_type.dart';
import '../../utils/globals/global_widgets/glow_pill_button.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});
  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  late final InboxController c = Get.put(InboxController());

  @override
  void dispose() {
    Get.delete<InboxController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          // ------------ content ------------
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      40.h,

                      // Segmented Control (All / Starred)
                      _SegmentedTabs(controller: c),

                      40.h,

                      // Empty state (when there are no chats)
                      _EmptyState(
                        onStartNewChat: () {
                          context.push(SearchScreen(assistantType: AssistantType.generic));
                        },
                      ),

                      120.h, // spacer for bottom nav notch
                    ],
                  ),
                ),
              ),
            ],
          ),

          // compose button (top-right)
          Positioned(
            top: 12,
            right: 12,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  50.w,
                  Text('Chats', style: context.labelSmall.copyWith(fontSize: 28)),
                  Spacer(),
                  _IconCircleButton(
                    icon: Image.asset(Assets.iconsEdit, height: 15, width: 15, color: Colors.white),
                    onTap: () {
                      context.push(SearchScreen(assistantType: AssistantType.generic));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  final InboxController controller;
  const _SegmentedTabs({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tab = controller.tab.value;

      return Container(
        height: 60,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(color: ColorConstants.darkGreyColor, borderRadius: BorderRadius.circular(18)),
        child: Stack(
          children: [
            // active pill
            AnimatedAlign(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              alignment: tab == 0 ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: (MediaQuery.of(context).size.width - 16 * 2 - 12) / 2,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.containerBgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: _TabBtn(label: 'All', selected: tab == 0, onTap: () => controller.setTab(0)),
                ),
                Expanded(
                  child: _TabBtn(label: 'Starred', selected: tab == 1, onTap: () => controller.setTab(1)),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _TabBtn extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _TabBtn({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Center(
        child: Text(
          label,
          style: context.labelSmall.copyWith(
            color: selected ? Colors.black : Colors.white.withAlpha(180),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onStartNewChat;
  const _EmptyState({required this.onStartNewChat});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        40.h,
        // inbox outline icon from assets if you have, else default icon
        SizedBox(
          height: 80,
          child: Center(
            child: Image.asset(
              Assets.iconsEmptyInbox,
              errorBuilder: (context, object, stackTrace) =>
                  const Icon(Icons.inbox_outlined, size: 72, color: Colors.white),
            ),
          ),
        ),
        16.h,
        Text('No Chats', style: context.labelSmall.copyWith(fontSize: 26)),
        10.h,
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Text(
            'As you talk with AI, your conversations will appear here.',
            textAlign: TextAlign.center,
            style: context.bodyLarge.copyWith(color: Colors.white.withAlpha(220), height: 1.35),
          ),
        ),
        24.h,

        // Start New Chat — reuse GlowPillButton (full-width outline look)
        SizedBox(
          width: double.infinity,
          child: GlowPillButton(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            showGlow: true,
            onTap: onStartNewChat,
            child: Text('Start New Chat', style: context.labelSmall),
          ),
        ),
      ],
    );
  }
}

class _IconCircleButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  const _IconCircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorConstants.containerBgColor.withAlpha(40),
            shape: BoxShape.circle,
            border: Border.all(color: ColorConstants.primaryColor.withAlpha(210), width: 1.2),
          ),
          child: icon,
        ),
      ),
    );
  }
}