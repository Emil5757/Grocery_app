import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';

/// Selectable category chip from the Filter sheet: filled green when selected,
/// green outline when not.
class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radius12.r);
    return Material(
      color: isSelected ? AppColors.primary : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: const BorderSide(color: AppColors.primary),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body16Regular.copyWith(
              color: isSelected ? AppColors.white : AppColors.textGrey,
            ),
          ),
        ),
      ),
    );
  }
}
