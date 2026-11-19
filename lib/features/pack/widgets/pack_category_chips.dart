import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/category_data.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

/// Horizontal category pills (Create My Pack). Selected: green pill.
class PackCategoryChips extends StatelessWidget {
  const PackCategoryChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final categories = CategoryData.shelves;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w),
      child: Row(
        children: [
          for (var i = 0; i < categories.length; i++)
            GestureDetector(
              onTap: () => onSelected(i),
              child: Container(
                margin: EdgeInsets.only(right: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: i == selected
                      ? AppColors.primary
                      : AppColors.transparent,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  categories[i].name,
                  style: i == selected
                      ? AppTextStyles.body16SemiBold.copyWith(
                          color: AppColors.white,
                        )
                      : AppTextStyles.label14Regular.copyWith(
                          color: AppColors.textGrey,
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
