import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/product_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/num_extensions.dart';

/// Bundle Details row: image | name | weight | price.
class BundleItemTile extends StatelessWidget {
  const BundleItemTile({
    super.key,
    required this.product,
    required this.quantity,
  });

  final ProductModel product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final kg = product.weightKg * quantity;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 22.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80.r,
            height: 70.r,
            child: Image.asset(product.image),
          ),
          20.horizontalSpace,
          Expanded(
            child: Text(product.name, style: AppTextStyles.body16Regular),
          ),
          12.horizontalSpace,
          Text(
            '${kg % 1 == 0 ? kg.toInt() : kg} Kg',
            style: AppTextStyles.label14Medium,
          ),
          24.horizontalSpace,
          SizedBox(
            width: 44.w,
            child: Text(
              (product.price * quantity).toPrice,
              textAlign: TextAlign.end,
              style: AppTextStyles.body16Bold,
            ),
          ),
        ],
      ),
    );
  }
}
