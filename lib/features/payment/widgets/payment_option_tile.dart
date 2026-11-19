import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/color_extensions.dart';
import '../data/models/payment_model.dart';

/// Bordered row: grey icon tile, then title and subtitle on two lines.
class PaymentOptionTile extends StatelessWidget {
  const PaymentOptionTile({super.key, required this.option, this.onTap});

  final OtherPaymentModel option;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final icon = option.icon;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radius16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius16.r),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 60.r,
              height: 60.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppSizes.radius12.r),
              ),
              child: icon == null
                  ? Icon(Icons.payments, color: AppColors.primary, size: 36.r)
                  : SvgPicture.asset(
                      icon,
                      height: 34.r,
                      colorFilter: option.iconColor?.toColorFilter,
                    ),
            ),
            20.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(option.title, style: AppTextStyles.section18Regular),
                  4.verticalSpace,
                  Text(
                    option.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.section18Regular,
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
