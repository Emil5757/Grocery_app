import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../data/models/checkout_model.dart';

/// Payment option tile (Master Card / PayPal / Cash On Delivery).
class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.method,
    required this.selected,
    required this.onTap,
  });

  final PaymentMethodModel method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 135.w,
        height: 66.h,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLight : AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radius8.r),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            method.icon != null
                ? SvgPicture.asset(method.icon!, height: 26.r)
                : Icon(Icons.payments, color: AppColors.cashNote, size: 26.r),
            6.verticalSpace,
            Text(
              method.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.label14Regular,
            ),
          ],
        ),
      ),
    );
  }
}
