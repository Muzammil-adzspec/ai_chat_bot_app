import 'package:ai_chat_bot_app/utils/extension/navigation_extension.dart';
import 'package:ai_chat_bot_app/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:ai_chat_bot_app/utils/constants/color_constants.dart';
import 'package:ai_chat_bot_app/utils/theme/text_theme.dart';
import 'package:ai_chat_bot_app/utils/globals/global_widgets/custom_scaffold.dart';
import 'package:ai_chat_bot_app/utils/globals/global_widgets/ai_logo_with_glow_bg.dart';
import 'package:ai_chat_bot_app/utils/generated_assets/assets.dart';
import 'package:get/get.dart';
import '../../controller/message_controller.dart';
import '../../utils/enums/assistant_type.dart';
import '../../utils/globals/global_widgets/glow_pill_button.dart';

class SearchScreen extends StatefulWidget {
  final AssistantType assistantType;
  const SearchScreen({super.key, required this.assistantType});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _expanded = false;
  final MessageController _messageController = Get.put(MessageController());
  final ScrollController _scroll = ScrollController();
  bool _stickToBottom = true;
  bool _showJumpToEnd = false;

  @override
  void initState() {
    super.initState();

    // messages change → autoscroll only if user is at/near bottom
    ever<List<ChatMsg>>(_messageController.messages, (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scroll.hasClients && _stickToBottom) {
          _scroll.animateTo(
            _scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        } else {
          // user is scrolled up → show arrow
          WidgetsBinding.instance.addPersistentFrameCallback((time) {
            setState(() => _showJumpToEnd = true);
          });
        }
      });
    });

    // listen to user scroll to toggle arrow
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    final pos = _scroll.position;
    const threshold = 24.0; // how close counts as "bottom"

    final atBottom = pos.pixels >= (pos.maxScrollExtent - threshold);
    if (atBottom && (!_stickToBottom || _showJumpToEnd)) {
      setState(() {
        _stickToBottom = true;
        _showJumpToEnd = false;
      });
    } else if (!atBottom && (_stickToBottom || !_showJumpToEnd)) {
      setState(() {
        _stickToBottom = false;
        _showJumpToEnd = true;
      });
    }
  }

  void _jumpToBottom() {
    if (!_scroll.hasClients) return;
    _scroll.animateTo(
      _scroll.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
    setState(() {
      _stickToBottom = true;
      _showJumpToEnd = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          // -------- CONTENT --------
          Obx(() {
            final msgs = _messageController.messages;

            if (msgs.isEmpty) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        children: [
                          30.h,
                          const AiLogoWithGlowBg(),
                          22.h,
                          Text('AI Chat - Bot', style: context.labelSmall.copyWith(fontSize: 28)),
                          const SizedBox(height: 16),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 560),
                            child: Column(
                              children: [
                                Text(
                                  "Hi, I'm AI ChatBot! Developed on OpenAI GPT-4o Mini. I'm here to assist you with guidance on crafting an impressive CV, writing effective cover letters, answering interview questions, and more.",
                                  textAlign: TextAlign.center,
                                  style: context.bodyLarge.copyWith(color: Colors.white.withAlpha(230), height: 1.4),
                                  maxLines: _expanded ? null : 3,
                                  overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                GestureDetector(
                                  onTap: () => setState(() => _expanded = !_expanded),
                                  child: Text(
                                    _expanded ? 'less' : 'more',
                                    style: context.displaySmall.copyWith(
                                      color: ColorConstants.primaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          16.h,
                          Text(
                            'Powered by AI ChatBot',
                            style: context.bodyLarge.copyWith(color: Colors.white.withAlpha(210)),
                          ),
                          20.h,
                          GlowPillButton(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                            showGlow: true,
                            width: MediaQuery.of(context).size.width * .7,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.wb_sunny_outlined, size: 25, color: Colors.white),
                                const SizedBox(width: 30),
                                Text('Examples', style: context.displayLarge),
                              ],
                            ),
                          ),
                          120.h,
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            // messages list
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 70),
              child: ListView.builder(
                controller: _scroll,
                itemCount: msgs.length,
                itemBuilder: (context, index) {
                  final m = msgs[index];
                  return MessageBubble(
                    fromUser: m.fromUser,
                    text: m.text,
                    // Actions (optional)
                    // onCopy: () => copyToClipboard(m.text),
                    // onRegenerate: m.fromUser ? null : () {
                    //   // last user text pakro aur dubara bhejo
                    //   final lastUser = msgs.lastWhereOrNull((e) => e.fromUser)?.text ?? '';
                    //   if (lastUser.isNotEmpty) {
                    //     _messageController.send(text: lastUser, who: AssistantType.doctor);
                    //   }
                    // },
                    onLike: () {}, // TODO: hook to feedback
                    onDislike: () {}, // TODO: hook to feedback
                  );
                },
              ),
            );
          }),

          // ---------- Header & Share ----------
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _IconCircleButton(icon: Icons.arrow_back_ios_new_rounded, onTap: () => context.pop()),
                _CenteredHeaderTitle(title: 'AI Chat - Bot'),
                GestureDetector(
                  onTap: () {
                    showShareChatSheet(
                      context,
                      onShareAll: () {
                        context.pop(); /* TODO */
                      },
                      onShareLast: () {
                        context.pop(); /* TODO */
                      },
                    );
                  },
                  child: Image.asset(Assets.iconsShare, height: 25, color: Colors.white),
                ),
              ],
            ),
          ),

          Positioned(
            right: MediaQuery.of(context).size.width / 3.5,
            // keep it above the input; also respects keyboard height
            bottom: MediaQuery.of(context).viewInsets.bottom + 76,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 180),
              offset: _showJumpToEnd ? Offset.zero : const Offset(0, 0.4),
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 180),
                opacity: _showJumpToEnd ? 1 : 0,
                child: _JumpToEndButton(onTap: _jumpToBottom),
              ),
            ),
          ),

          // ---------- Bottom MessageBar ----------
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(bottom: 10, left: 0, right: 0, top: 0),
              child: MessageBar(),
            ),
          ),
        ],
      ),
    );
  }
}

class _JumpToEndButton extends StatelessWidget {
  final VoidCallback onTap;
  const _JumpToEndButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: ColorConstants.primaryColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: ColorConstants.primaryColor, width: 1.2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_downward_rounded, size: 20, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                'Jump to latest',
                style: context.bodyLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
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
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: ColorConstants.containerBgColor.withAlpha(40),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorConstants.primaryColor.withAlpha(210), width: 1.2),
        ),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}

class _CenteredHeaderTitle extends StatelessWidget {
  final String title;
  const _CenteredHeaderTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(Assets.iconsLogo, height: 30),
        const SizedBox(width: 8),
        Text(title, style: context.labelSmall.copyWith(fontSize: 24)),
      ],
    );
  }
}

class MessageBar extends StatefulWidget {
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onChanged;
  final VoidCallback? onMic;

  const MessageBar({super.key, this.onSubmitted, this.onChanged, this.onMic});

  @override
  State<MessageBar> createState() => _MessageBarState();
}

class _MessageBarState extends State<MessageBar> {
  final MessageController _messageController = Get.put(MessageController());
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Rebuild when focus OR text changes
    _focus.addListener(() => setState(() {}));
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = ColorConstants.primaryColor;
    final showSend = _focus.hasFocus;
    return Row(
      children: [
        // PLUS button → opens attachment menu
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _openAttachmentMenu(context),
          child: Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: ColorConstants.containerBgColor.withAlpha(40),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: border.withAlpha(210), width: 1.2),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(width: 12),

        // SEARCHABLE TEXTFIELD
        Expanded(
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: ColorConstants.darkGreyColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: border.withAlpha(210), width: 1.2),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 20, color: Colors.white70),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focus,
                    style: context.displaySmall.copyWith(color: Colors.white),
                    cursorColor: ColorConstants.primaryColor,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      hintText: 'Search or type a message',
                      hintStyle: context.displaySmall.copyWith(color: Colors.white.withAlpha(180)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: showSend
                      ? IconButton(
                          key: const ValueKey('send'),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            _messageController.send(text: _controller.text, who: AssistantType.doctor);
                            _controller.clear();
                            _focus.unfocus();
                          },
                          icon: CircleAvatar(
                            backgroundColor: ColorConstants.primaryColor,
                            child: Icon(Icons.arrow_upward, color: ColorConstants.whiteColor),
                          ),
                        )
                      : InkWell(
                          key: const ValueKey('mic'),
                          borderRadius: BorderRadius.circular(14),
                          onTap: widget.onMic,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(20),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.mic_none_rounded, color: Colors.white, size: 22),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ----- Attachment Menu -----
  void _openAttachmentMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: 'attachments',
      barrierDismissible: true,
      barrierColor: Colors.black.withAlpha(180),
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        // full-screen overlay anchored from the bottom-left (near + button)
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque, // transparent areas bhi tap lein
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                // Close button (top-left of overlay)
                Positioned(top: 12, left: 12, child: _CloseRound(onTap: () => Navigator.of(context).pop())),

                // Items column
                Positioned(
                  left: 16,
                  bottom: 90, // a little above the message bar
                  right: 16,
                  child: _AttachmentList(
                    onItemTap: (type) {
                      Navigator.of(context).pop();
                      // TODO: handle each type
                      // e.g., if (type == AttachType.camera) openCamera();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum AttachType { camera, gallery, scanText, files, video, audio }

class _AttachmentList extends StatelessWidget {
  final void Function(AttachType) onItemTap;
  const _AttachmentList({required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    // WhatsApp-like vertical options
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AttachItem(
          icon: Icons.photo_camera_outlined,
          label: 'Camera',
          showNew: true,
          onTap: () => onItemTap(AttachType.camera),
        ),
        _AttachItem(
          icon: Icons.photo_library_outlined,
          label: 'Gallery',
          showNew: true,
          onTap: () => onItemTap(AttachType.gallery),
        ),
        _AttachItem(
          icon: Icons.document_scanner_outlined,
          label: 'Scan a Text',
          onTap: () => onItemTap(AttachType.scanText),
        ),
        _AttachItem(
          icon: Icons.insert_drive_file_outlined,
          label: 'Files',
          showNew: true,
          onTap: () => onItemTap(AttachType.files),
        ),
        _AttachItem(
          icon: Icons.videocam_outlined,
          label: 'Video',
          showNew: true,
          onTap: () => onItemTap(AttachType.video),
        ),
        _AttachItem(
          icon: Icons.mic_none_rounded,
          label: 'Audio',
          showNew: true,
          onTap: () => onItemTap(AttachType.audio),
        ),
      ],
    );
  }
}

class _AttachItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool showNew;
  final VoidCallback onTap;

  const _AttachItem({required this.icon, required this.label, required this.onTap, this.showNew = false});

  @override
  Widget build(BuildContext context) {
    final c = ColorConstants.primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Row(
          children: [
            // round icon
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(18),
                shape: BoxShape.circle,
                border: Border.all(color: c.withAlpha(210), width: 1.0),
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),

            // label + NEW chip
            Container(
              decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Text(label, style: context.labelSmall),
                  if (showNew) ...[const SizedBox(width: 8), _NewChip()],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor.withAlpha(200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'NEW',
        style: context.bodySmall.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _CloseRound extends StatelessWidget {
  final VoidCallback onTap;
  const _CloseRound({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: ColorConstants.containerBgColor.withAlpha(40),
          shape: BoxShape.circle,
          border: Border.all(color: ColorConstants.primaryColor.withAlpha(210), width: 1.2),
        ),
        child: const Icon(Icons.close, color: Colors.white, size: 18),
      ),
    );
  }
}

void showShareChatSheet(BuildContext context, {required VoidCallback onShareAll, required VoidCallback onShareLast}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withAlpha(160),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22)),
    ),
    builder: (_) {
      return SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          decoration: BoxDecoration(
            color: ColorConstants.darkGreyColor, // your sheet bg
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.h,
              // grabber / title
              Text('Share Chat', style: context.displayLarge.copyWith(fontWeight: FontWeight.w700)),
              30.h,
              GlowPillButton(
                width: double.infinity,
                fillColor: ColorConstants.darkGreyColor,
                onTap: onShareAll,
                child: Text("Share All Text"),
              ),
              10.h,
              GlowPillButton(
                width: double.infinity,
                fillColor: ColorConstants.darkGreyColor,
                onTap: onShareLast,
                child: Text("Share Last Message"),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class MessageBubble extends StatelessWidget {
  final bool fromUser;
  final String text;

  final VoidCallback? onCopy;
  final VoidCallback? onRegenerate;
  final VoidCallback? onLike;
  final VoidCallback? onDislike;

  const MessageBubble({
    super.key,
    required this.fromUser,
    required this.text,
    this.onCopy,
    this.onRegenerate,
    this.onLike,
    this.onDislike,
  });

  @override
  Widget build(BuildContext context) {
    final maxW = MediaQuery.of(context).size.width * 0.86;

    // Colors
    final border = ColorConstants.primaryColor;
    final bgUser = ColorConstants.darkGreyColor;
    final bgBot = ColorConstants.containerBgColor.withAlpha(40);

    // Alignments
    final align = fromUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final rowAlign = fromUser ? MainAxisAlignment.end : MainAxisAlignment.start;

    // Avatar (round)
    Widget avatar(bool isUser) {
      return CircleAvatar(
        radius: 16,
        backgroundColor: isUser ? border : Colors.white.withAlpha(30),
        child: isUser
            ? const Icon(Icons.person, size: 18, color: Colors.white)
            : Image.asset(Assets.iconsLogo, height: 18), // your bot logo
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: align,
        children: [
          // Name row
          Row(
            mainAxisAlignment: rowAlign,
            children: [
              if (!fromUser) avatar(false),
              if (!fromUser) const SizedBox(width: 8),
              Text(
                fromUser ? 'You' : 'AI ChatBot',
                style: context.bodyLarge.copyWith(fontWeight: FontWeight.w700, color: Colors.white.withAlpha(230)),
              ),
              if (fromUser) const SizedBox(width: 8),
              if (fromUser) avatar(true),
            ],
          ),
          const SizedBox(height: 8),

          // Bubble
          Row(
            mainAxisAlignment: rowAlign,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxW),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  decoration: BoxDecoration(
                    color: fromUser ? bgUser : bgBot,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(14),
                      topRight: const Radius.circular(14),
                      bottomLeft: Radius.circular(fromUser ? 14 : 4),
                      bottomRight: Radius.circular(fromUser ? 4 : 14),
                    ),
                    border: Border.all(color: border.withAlpha(160), width: 1),
                  ),
                  child: Text(
                    text.isEmpty ? '…' : text,
                    style: context.bodyLarge.copyWith(color: Colors.white.withAlpha(230), height: 1.45),
                  ),
                ),
              ),
            ],
          ),

          // Actions (bot only)
          if (!fromUser) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _ChipButton(icon: Icons.copy_rounded, label: 'Copy', onTap: onCopy),
                _ChipButton(icon: Icons.autorenew_rounded, label: 'Regenerate', onTap: onRegenerate),
                _ChipButton(icon: Icons.thumb_up_alt_outlined, label: null, onTap: onLike),
                _ChipButton(icon: Icons.thumb_down_alt_outlined, label: null, onTap: onDislike),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ChipButton extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback? onTap;

  const _ChipButton({required this.icon, this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorConstants.primaryColor.withAlpha(180), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            if (label != null) ...[const SizedBox(width: 8), Text(label!, style: context.bodyLarge)],
          ],
        ),
      ),
    );
  }
}