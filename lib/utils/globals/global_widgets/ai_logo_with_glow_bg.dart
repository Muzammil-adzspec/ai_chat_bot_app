import 'package:flutter/material.dart';
import '../../constants/color_constants.dart';
import '../../generated_assets/assets.dart';

class AiLogoWithGlowBg extends StatelessWidget {
  const AiLogoWithGlowBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Inner radial gradient disc (fades BEFORE the edge)
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // Tip: transparent at stop < 1.0 to avoid hard rim
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.4,
                colors: [
                  ColorConstants.primaryColor.withAlpha(140), // bright center
                  ColorConstants.primaryColor.withAlpha(10),
                  Colors.transparent,
                ],
                tileMode: TileMode.mirror,
                stops: [.1, .3, .4],
              ),
            ),
          ),

          // Logo
          SizedBox(height: 120, width: 120, child: Image.asset(Assets.iconsLogo)),
        ],
      ),
    );
  }
}