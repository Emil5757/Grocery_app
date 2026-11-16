import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';

/// "Order your Daily Groceries #Free Delivery" promo card.
class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 160.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.banner,
          borderRadius: BorderRadius.circular(AppSizes.radius16.r),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -6.w,
              bottom: -8.h,
              height: 165.h,
              child: Image.asset(AppAssets.packBundle2, fit: BoxFit.contain),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22.w, 22.h, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppTexts.bannerTitle, style: AppTextStyles.banner22Bold),
                  10.verticalSpace,
                  Text(
                    AppTexts.freeDelivery,
                    style: AppTextStyles.body16Bold.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
