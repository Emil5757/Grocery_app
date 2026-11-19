import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_card_scaffold.dart';
import '../../../common/widgets/custom_summary_row.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/num_extensions.dart';
import '../data/models/order_model.dart';
import '../widgets/order_timeline.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final bold = AppTextStyles.section18Bold;
    return CustomCardScaffold(
      title: AppTexts.myOrderDetails,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppTexts.orderIdHash(order.id), style: bold),
          24.verticalSpace,
          OrderTimeline(steps: OrderStep.demo, reached: order.status.step),
          10.verticalSpace,
          Text(AppTexts.productDetailsTitle, style: bold),
          for (final line in order.lines)
            Container(
              padding: EdgeInsets.symmetric(vertical: 18.h),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.divider)),
              ),
              child: Row(
                children: [
                  SizedBox(width: 80.r, height: 70.r, child: Image.asset(line.product.image)),
                  20.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(line.name, style: AppTextStyles.section18Regular),
                        6.verticalSpace,
                        Text(
                          line.weight,
                          style: AppTextStyles.section18Regular.copyWith(color: AppColors.textGrey),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(line.total.toPrice, style: AppTextStyles.title20Regular),
                      14.verticalSpace,
                      Text(AppTexts.timesQty(line.quantity), style: AppTextStyles.label14Medium),
                    ],
                  ),
                ],
              ),
            ),
          16.verticalSpace,
          CustomSummaryRow(
            label: AppTexts.totalAmount,
            value: order.total.toPrice,
            labelStyle: bold,
            valueStyle: bold,
          ),
          CustomSummaryRow(
            label: AppTexts.paidFrom,
            value: AppTexts.creditCard,
            labelStyle: bold,
            valueStyle: bold,
          ),
        ],
      ),
    );
  }
}
