import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_sizes.dart';
import 'app_text_styles.dart';

abstract final class AppButtonStyle {
  static ButtonStyle get primary => ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.disabled,
        disabledForegroundColor: AppColors.textGrey,
        elevation: 0,
        minimumSize: Size(double.infinity, AppSizes.buttonHeight.h),
        textStyle: AppTextStyles.button18Bold,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius16.r),
        ),
      );

  static ButtonStyle get outlined => OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        minimumSize: Size(double.infinity, AppSizes.buttonHeight.h),
        textStyle: AppTextStyles.body16Medium,
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius16.r),
        ),
      );
}
