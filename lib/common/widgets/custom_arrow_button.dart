import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

/// Green rounded square with a forward arrow (the "Log In" / "Sign up" submit).
class CustomArrowButton extends StatelessWidget {
  const CustomArrowButton({super.key, required this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radius16.r);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(color: AppColors.shadow, blurRadius: 16.r, offset: Offset(0, 8.h)),
        ],
      ),
      child: Material(
        color: onTap == null ? AppColors.disabled : AppColors.primary,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: SizedBox(
            width: 80.w,
            height: 56.h,
            child: Icon(Icons.arrow_forward, color: AppColors.white, size: AppSizes.icon28.r),
          ),
        ),
      ),
    );
  }
}
