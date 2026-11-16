import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/pack_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

/// "Pack Details" row: small image box, name, weight.
class PackItemTile extends StatelessWidget {
  const PackItemTile({super.key, required this.item});

  final PackItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppSizes.radius8.r),
            ),
            child: Image.asset(item.product.image),
          ),
          14.horizontalSpace,
          Expanded(
            flex: 3,
            child: Text(
              item.product.name.split(' ').first,
              style: AppTextStyles.body16Regular,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text('${item.kg} Kg', style: AppTextStyles.caption12Regular),
          ),
        ],
      ),
    );
  }
}
