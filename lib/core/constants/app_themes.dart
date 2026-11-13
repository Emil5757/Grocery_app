import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_button_style.dart';
import 'app_colors.dart';
import 'app_sizes.dart';
import 'app_text_styles.dart';

abstract final class AppThemes {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        fontFamily: AppTextStyles.fontFamily,
        scaffoldBackgroundColor: AppColors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.white,
          error: AppColors.error,
        ),
        dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1, space: 1),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.transparent,
          elevation: 0,
          centerTitle: true,
          foregroundColor: AppColors.textPrimary,
          titleTextStyle: AppTextStyles.title20Bold,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: AppButtonStyle.primary),
        outlinedButtonTheme: OutlinedButtonThemeData(style: AppButtonStyle.outlined),
        textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.primary),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radius24.r)),
          ),
        ),
      );
}
