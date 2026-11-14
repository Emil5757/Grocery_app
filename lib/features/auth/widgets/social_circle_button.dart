import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';

/// Round outlined brand button (Apple / Google / Twitter / Facebook row).
class SocialCircleButton extends StatelessWidget {
  const SocialCircleButton({
    super.key,
    required this.asset,
    required this.color,
    required this.onTap,
    this.iconHeight = 30,
  });

  final String asset;
  final Color color;
  final VoidCallback onTap;
  final double iconHeight;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: CircleBorder(side: BorderSide(color: color, width: 1.2)),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox.square(
          dimension: 60.r,
          child: Center(child: SvgPicture.asset(asset, height: iconHeight.r)),
        ),
      ),
    );
  }
}
