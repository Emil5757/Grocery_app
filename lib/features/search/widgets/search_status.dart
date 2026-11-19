import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';

/// "12 Products Found" with "2 filters on · Clear filters" on the right
/// when a filter is active.
class SearchCountRow extends StatelessWidget {
  const SearchCountRow({
    super.key,
    required this.count,
    required this.activeFilters,
    required this.onClearFilters,
    this.style,
  });

  final int count;
  final int activeFilters;
  final VoidCallback onClearFilters;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            AppTexts.productsFound(count),
            style: style ?? AppTextStyles.section18Medium,
          ),
        ),
        if (activeFilters > 0)
          Flexible(
            child: TextButton(
              onPressed: onClearFilters,
              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size(0, 32.h)),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${AppTexts.filtersOn(activeFilters)} · ${AppTexts.clearFilters}',
                  style: AppTextStyles.label14Medium.copyWith(color: AppColors.primary),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Shown when nothing matches the query and filters.
class SearchEmpty extends StatelessWidget {
  const SearchEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: Column(
        children: [
          Container(
            width: 96.r,
            height: 96.r,
            decoration: const BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
            child: Icon(Icons.search_off, color: AppColors.primary, size: AppSizes.icon28.r * 1.6),
          ),
          20.verticalSpace,
          Text(AppTexts.noProductsFound, style: AppTextStyles.title20Bold),
          8.verticalSpace,
          Text(AppTexts.noProductsHint, textAlign: TextAlign.center, style: AppTextStyles.body16Grey),
        ],
      ),
    );
  }
}
