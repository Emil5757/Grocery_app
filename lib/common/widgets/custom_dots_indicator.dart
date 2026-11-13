import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_durations.dart';

/// Pill-shaped page dots (product image carousel, onboarding).
class CustomDotsIndicator extends StatelessWidget {
  const CustomDotsIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor = AppColors.primary,
    this.inactiveColor,
  });

  final int count;
  final int currentIndex;
  final Color activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final active = i == currentIndex;
        return AnimatedContainer(
          duration: AppDurations.normal,
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          width: active ? 18.w : 10.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: active ? activeColor : (inactiveColor ?? activeColor.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}
