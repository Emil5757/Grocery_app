import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/models/product_model.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/num_extensions.dart';

/// Curved green bar at the bottom of Create My Pack: picked products with
/// quantity badges, running total and a next arrow.
class PackSelectionBar extends StatelessWidget {
  const PackSelectionBar({
    super.key,
    required this.selection,
    required this.total,
    required this.onNext,
  });

  final Map<ProductModel, int> selection;
  final num total;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSizes.pagePadding.w,
        30.h,
        AppSizes.pagePadding.w,
        14.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(1.sw / 2, 28.h),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: [
                    for (final e in selection.entries) ...[
                      _SelectedProduct(product: e.key, quantity: e.value),
                      6.horizontalSpace,
                    ],
                  ],
                ),
              ),
            ),
            12.horizontalSpace,
            Text(
              total.toPrice,
              style: AppTextStyles.title20Bold.copyWith(color: AppColors.white),
            ),
            12.horizontalSpace,
            Material(
              color: AppColors.white,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onNext,
                customBorder: const CircleBorder(),
                child: SizedBox.square(
                  dimension: 50.r,
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.icArrowRight,
                      width: 26.r,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedProduct extends StatelessWidget {
  const _SelectedProduct({required this.product, required this.quantity});

  final ProductModel product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 50.r,
          height: 50.r,
          padding: EdgeInsets.all(8.r),
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset(product.image),
        ),
        if (quantity > 1)
          Positioned(
            top: -6.r,
            right: -4.r,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.r, vertical: 2.r),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColors.primary),
              ),
              child: Text(
                AppTexts.quantityBadge(quantity),
                style: AppTextStyles.caption12Regular,
              ),
            ),
          ),
      ],
    );
  }
}
