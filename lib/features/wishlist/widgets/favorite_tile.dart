import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/models/product_model.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/num_extensions.dart';

/// Image | name, unit, price | delete (top) + add to cart (bottom).
class FavoriteTile extends StatelessWidget {
  const FavoriteTile({
    super.key,
    required this.product,
    required this.onTap,
    required this.onDelete,
    required this.onAddToCart,
  });

  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.divider)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 80.r,
              height: 80.r,
              child: Image.asset(product.image),
            ),
            20.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: AppTextStyles.body16Regular),
                  4.verticalSpace,
                  Text(product.unit, style: AppTextStyles.label14Grey),
                  12.verticalSpace,
                  Text(
                    product.price.toPrice,
                    style: AppTextStyles.title20Regular,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_outline,
                    size: AppSizes.icon24.r,
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  onPressed: onAddToCart,
                  icon: SvgPicture.asset(
                    AppAssets.icCartOutline,
                    width: AppSizes.icon24.r,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
