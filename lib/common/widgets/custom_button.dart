import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';

/// Full-width green button: "Buy Now", "Checkout", "Verify", "Save".
/// `onTap: null` renders the grey disabled state ("Apply" in the cart).
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.isLoading = false,
    this.backgroundColor = AppColors.primary,
    this.textStyle,
    this.hasShadow = false,
  });

  final String text;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool isLoading;
  final Color backgroundColor;
  final TextStyle? textStyle;

  /// Soft green glow under the button (Login screen).
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null && !isLoading;
    return Container(
      width: width ?? double.infinity,
      height: height ?? AppSizes.buttonHeight.h,
      decoration: hasShadow && enabled
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radius16.r),
              boxShadow: [
                BoxShadow(color: AppColors.shadow, blurRadius: 16.r, offset: Offset(0, 8.h)),
              ],
            )
          : null,
      child: Material(
        color: enabled ? backgroundColor : AppColors.disabled,
        borderRadius: BorderRadius.circular(AppSizes.radius16.r),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(AppSizes.radius16.r),
          child: Center(
            child: isLoading
                ? SizedBox.square(
                    dimension: 24.r,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    text,
                    style: (textStyle ?? AppTextStyles.button18Bold).copyWith(
                      color: enabled ? null : AppColors.textGrey,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
