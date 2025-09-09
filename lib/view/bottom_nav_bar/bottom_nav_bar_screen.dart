import 'package:ai_chat_bot_app/utils/extension/size_extension.dart';
import 'package:ai_chat_bot_app/utils/globals/global_widgets/custom_scaffold.dart';
import 'package:ai_chat_bot_app/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/bottom_nav_controller.dart';
import '../../utils/constants/color_constants.dart';
import '../../utils/generated_assets/assets.dart';
import '../all_bots/all_bots_screen.dart';
import '../home/home_screen.dart';
import '../inbox/inbox_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final BottomNavController _controller = Get.put(BottomNavController());
  List<Widget> screens = <Widget>[const AllBotsScreen(), const HomeScreen(), const InboxScreen()];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScaffold(
        bodyPadding: EdgeInsets.zero,
        floatingActionButton: GestureDetector(
          onTap: () async {
            _controller.changeTab(1);
            // Subscription check here
            // if (subscriptionController.isSubscribed.value || kDebugMode) {
            //   // Unlimited use
            //   await performScan();
            // } else {
            //   // Non-subscribed: limit to 3 per day
            //   if (await subscriptionController.canScanToday()) {
            //     await subscriptionController.incrementScanCount();
            //     await performScan();
            //   } else {
            //     GlobalFunctions.showErrorSnackBar(
            //       title: "Error",
            //       message: "You have reached today's image scanning limit",
            //     );
            //   }
            // }
          },
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: ColorConstants.primaryDarkColor,
              shape: BoxShape.circle,
              border: Border.all(color: ColorConstants.whiteColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.primaryColor.withAlpha(100),
                  blurRadius: 10,
                  spreadRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(child: Image.asset(Assets.gifLogoSpin, height: 30, color: ColorConstants.whiteColor)),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 65,
              decoration: BoxDecoration(
                color: ColorConstants.darkGreyColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  30.w,
                  GestureDetector(
                    onTap: () async {
                      _controller.changeTab(0);
                      // await interstitialController.loadInterstitialAd(
                      //   onSuccess: () {
                      //     _controller.setCurrentTab(0);
                      //   },
                      // );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          Assets.iconsHome,
                          height: 22,
                          color: _controller.tab.value == 0 ? ColorConstants.primaryColor : ColorConstants.whiteColor,
                        ),
                        3.h,
                        Text(
                          "AI Bots",
                          style: context.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _controller.tab.value == 0 ? ColorConstants.primaryColor : ColorConstants.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      _controller.changeTab(2);
                      // await interstitialController.loadInterstitialAd(
                      //   onSuccess: () {
                      //     _controller.setCurrentTab(1);
                      //   },
                      // );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          Assets.iconsInbox,
                          height: 25,
                          color: _controller.tab.value == 2 ? ColorConstants.primaryColor : ColorConstants.whiteColor,
                        ),
                        3.h,
                        Text(
                          "Inbox",
                          style: context.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _controller.tab.value == 2 ? ColorConstants.primaryColor : ColorConstants.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  30.w,
                ],
              ),
            ),
            // Obx(() {
            //   if (subscriptionController.isSubscribed.value) {
            //     return SizedBox.shrink();
            //   }
            //
            //   if (bannerAdController.isBannerAdReady.value) {
            //     return Container(
            //       alignment: Alignment.center,
            //       width: bannerAdController.bannerAd.size.width.toDouble(),
            //       height: bannerAdController.bannerAd.size.height.toDouble(),
            //       child: AdWidget(ad: bannerAdController.bannerAd),
            //     );
            //   } else if (bannerAdController.isBannerFailed.value) {
            //     return SizedBox.shrink();
            //   } else {
            //     return Container(height: 50, alignment: Alignment.center, child: Text("Ad is loading..."));
            //   }
            // }),
            10.h,
          ],
        ),
        body: screens[_controller.tab.value],
      );
    });
  }
}