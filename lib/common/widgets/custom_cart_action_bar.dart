import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import 'custom_button.dart';

/// Bottom bar of the detail screens: square outlined cart button + wide
/// green button ("Buy Now").
class CustomCartActionBar extends StatelessWidget {
  const CustomCartActionBar({
    super.key,
    required this.buttonText,
    required this.onButtonTap,
    required this.onCartTap,
  });

  final String buttonText;
  final VoidCallback onButtonTap;
  final VoidCallback onCartTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radius16.r);
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.pagePadding.w,
          12.h,
          AppSizes.pagePadding.w,
          16.h,
        ),
        child: Row(
          children: [
            Material(
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: radius,
                side: const BorderSide(color: AppColors.divider),
              ),
              child: InkWell(
                onTap: onCartTap,
                borderRadius: radius,
                child: SizedBox(
                  width: 60.r,
                  height: AppSizes.buttonHeight.h,
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.icCartOutline,
                      width: 26.r,
                    ),
                  ),
                ),
              ),
            ),
            20.horizontalSpace,
            Expanded(
              child: CustomButton(text: buttonText, onTap: onButtonTap),
            ),
          ],
        ),
      ),
    );
  }
}
