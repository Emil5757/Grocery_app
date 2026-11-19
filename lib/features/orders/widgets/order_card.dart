import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/order_model.dart';
import 'order_status_bar.dart';

/// "Oreder ID: … 25 Nov / Status: ●──●──○──○" card.
class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, required this.onTap});

  final OrderModel order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final grey = AppTextStyles.body16Regular.copyWith(color: AppColors.textGrey);
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppSizes.radius12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radius12.r),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 14.h),
          child: Column(
            children: [
              Row(
                children: [
                  Text(AppTexts.orderIdLabel, style: grey),
                  Expanded(child: Text(order.id, style: AppTextStyles.body16Regular)),
                  Text(order.date, style: grey),
                ],
              ),
              16.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 66.w, child: Text(AppTexts.statusLabel, style: grey)),
                  Expanded(child: OrderStatusBar(status: order.status)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
