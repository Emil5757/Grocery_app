import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_texts.dart';

/// Green cart in a light-green circle above "Welcome to our / E-Grocery".
/// Login options uses the large version, Login (and Sign up) the compact one.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.circleSize,
    required this.iconWidth,
    required this.titleStyle,
    required this.gap,
  });

  final double circleSize;
  final double iconWidth;
  final TextStyle titleStyle;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: circleSize.r,
          height: circleSize.r,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(AppAssets.icCart, width: iconWidth.r),
        ),
        gap.verticalSpace,
        Text.rich(
          TextSpan(
            text: '${AppTexts.welcomeTo}\n',
            style: titleStyle,
            children: [
              TextSpan(
                text: AppTexts.eGrocery,
                style: titleStyle.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
