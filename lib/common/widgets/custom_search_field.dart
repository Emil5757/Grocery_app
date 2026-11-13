import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_texts.dart';

/// Grey filled search box. `onFilterTap` adds the green filter square used on
/// the Search screen; without it the search icon sits on the right (Search
/// Results).
class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.controller,
    this.hint = AppTexts.search,
    this.onChanged,
    this.onSubmitted,
    this.onFilterTap,
    this.readOnly = false,
    this.onTap,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onFilterTap;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final hasFilter = onFilterTap != null;
    final radius = BorderRadius.circular(AppSizes.radius12.r);
    final searchIcon = Icon(
      Icons.search,
      size: AppSizes.icon24.r,
      color: hasFilter ? AppColors.primary : AppColors.textPrimary,
    );

    return Container(
      height: AppSizes.inputHeight.h,
      decoration: BoxDecoration(color: AppColors.background, borderRadius: radius),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              readOnly: readOnly,
              onTap: onTap,
              autofocus: autofocus,
              textInputAction: TextInputAction.search,
              style: AppTextStyles.body16Regular,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTextStyles.body16Regular,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                prefixIcon: hasFilter ? searchIcon : null,
                suffixIcon: hasFilter ? null : searchIcon,
              ),
            ),
          ),
          if (hasFilter)
            Material(
              color: AppColors.primaryDark,
              borderRadius: radius,
              child: InkWell(
                onTap: onFilterTap,
                borderRadius: radius,
                child: SizedBox(
                  width: AppSizes.inputHeight.h,
                  height: AppSizes.inputHeight.h,
                  child: Icon(Icons.tune, color: AppColors.white, size: AppSizes.icon24.r),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
