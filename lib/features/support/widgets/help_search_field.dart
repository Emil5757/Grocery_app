import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';

/// Help's 48 px grey search box (radius 9) with the outline magnifier on
/// the right. Lighter than the shared `CustomSearchField`, as designed.
class HelpSearchField extends StatelessWidget {
  const HelpSearchField({super.key, required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(9.r),
      borderSide: BorderSide.none,
    );
    return SizedBox(
      height: 48.h,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        textAlignVertical: TextAlignVertical.center,
        style: AppTextStyles.body16Regular,
        decoration: InputDecoration(
          hintText: AppTexts.search,
          hintStyle: AppTextStyles.body16Regular.copyWith(color: AppColors.searchHint),
          filled: true,
          fillColor: AppColors.background,
          hoverColor: AppColors.transparent,
          // The design's text starts 21 px in; the field adds 4 of its own.
          contentPadding: EdgeInsets.only(left: 17.w),
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: SvgPicture.asset(AppAssets.icSearchOutline, width: 24.r),
          ),
          suffixIconConstraints: BoxConstraints(minWidth: 39.w),
        ),
      ),
    );
  }
}
