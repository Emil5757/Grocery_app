import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

/// Gilroy type scale taken from the designs (414 x 896 frame).
///
/// Naming: `<role><size><weight>`. Use `.copyWith(color: ...)` for colour
/// variants instead of adding new styles for every colour.
abstract final class AppTextStyles {
  static const String fontFamily = 'Gilroy';

  static TextStyle _style(double size, FontWeight weight, {Color? color, double? height}) =>
      TextStyle(
        fontFamily: fontFamily,
        fontSize: size.sp,
        fontWeight: weight,
        color: color ?? AppColors.textPrimary,
        height: height,
      );

  // Display: "Welcome Back to our grocery shop", "Choose a Category"
  static TextStyle get display32Bold => _style(32, FontWeight.w700, height: 1.25);

  // Headlines: product name, onboarding title, "Log In"
  static TextStyle get headline24Bold => _style(24, FontWeight.w700);
  static TextStyle get headline24SemiBold => _style(24, FontWeight.w600);

  // App bar title, big prices
  static TextStyle get title20Bold => _style(20, FontWeight.w700);
  static TextStyle get title20SemiBold => _style(20, FontWeight.w600);
  static TextStyle get title20Regular => _style(20, FontWeight.w400);

  // Section titles: "Product Details", "Add Coupon", "Sort By"
  static TextStyle get section18Bold => _style(18, FontWeight.w700);
  static TextStyle get section18SemiBold => _style(18, FontWeight.w600);
  static TextStyle get section18Medium => _style(18, FontWeight.w500);
  static TextStyle get section18Regular => _style(18, FontWeight.w400);

  // Body: list rows, inputs, product names
  static TextStyle get body16SemiBold => _style(16, FontWeight.w600);
  static TextStyle get body16Medium => _style(16, FontWeight.w500);
  static TextStyle get body16Regular => _style(16, FontWeight.w400);
  static TextStyle get body16Grey =>
      _style(16, FontWeight.w400, color: AppColors.textGrey, height: 1.5);

  // Small: labels, weights, nav labels
  static TextStyle get label14Medium => _style(14, FontWeight.w500);
  static TextStyle get label14Regular => _style(14, FontWeight.w400);
  static TextStyle get label14Grey => _style(14, FontWeight.w400, color: AppColors.textGrey);
  static TextStyle get caption12Regular => _style(12, FontWeight.w400);
  static TextStyle get caption12Grey => _style(12, FontWeight.w400, color: AppColors.textGrey);

  // Buttons
  static TextStyle get button18Bold =>
      _style(18, FontWeight.w700, color: AppColors.white).copyWith(letterSpacing: 1);
  static TextStyle get button16SemiBold => _style(16, FontWeight.w600, color: AppColors.white);

  // Prices
  static TextStyle get price28Bold => _style(28, FontWeight.w700, color: AppColors.primary);
  static TextStyle get price16Bold => _style(16, FontWeight.w700);
  static TextStyle get oldPrice16 => _style(16, FontWeight.w600).copyWith(
        decoration: TextDecoration.lineThrough,
        decorationColor: AppColors.textPrimary,
      );
}
