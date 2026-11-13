import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';

/// Bordered button, e.g. "See All" in the filter sheet.
class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.borderColor = AppColors.primary,
    this.textStyle,
  });

  final String text;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color borderColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radius12.r);
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? AppSizes.buttonHeight.h,
      child: Material(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: borderColor),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Center(
            child: Text(
              text,
              style: textStyle ?? AppTextStyles.body16Regular.copyWith(color: AppColors.textGrey),
            ),
          ),
        ),
      ),
    );
  }
}
