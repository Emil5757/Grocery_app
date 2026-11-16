import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/models/category_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/color_extensions.dart';

/// Round icon + label. Selected: green circle, white icon, green label.
class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final CategoryModel category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 94.r,
            height: 94.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : AppColors.background,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              category.icon,
              width: 40.r,
              height: 36.r,
              colorFilter: (selected ? AppColors.white : AppColors.textPrimary)
                  .toColorFilter,
            ),
          ),
          14.verticalSpace,
          Text(
            category.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: selected
                ? AppTextStyles.body16Bold.copyWith(color: AppColors.primary)
                : AppTextStyles.body16Regular.copyWith(
                    color: AppColors.textGrey,
                  ),
          ),
        ],
      ),
    );
  }
}
