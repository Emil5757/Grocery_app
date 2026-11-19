import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/product_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/num_extensions.dart';

/// One live result under the Search box: photo, name, unit and price.
class SearchProductTile extends StatelessWidget {
  const SearchProductTile({super.key, required this.product, required this.onTap});

  final ProductModel product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.divider)),
        ),
        child: Row(
          children: [
            Container(
              width: 56.r,
              height: 56.r,
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppSizes.radius12.r),
              ),
              child: Image.asset(product.image, fit: BoxFit.contain),
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body16Medium,
                  ),
                  4.verticalSpace,
                  Text(product.unit, style: AppTextStyles.label14Grey),
                ],
              ),
            ),
            12.horizontalSpace,
            Text(product.price.toPrice, style: AppTextStyles.price16Bold),
          ],
        ),
      ),
    );
  }
}
