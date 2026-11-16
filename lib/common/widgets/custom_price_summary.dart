import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_texts.dart';
import 'custom_dashed_divider.dart';
import 'custom_summary_row.dart';

/// Total Item / Weight / Price / Discount, dashed line, Total Price
/// (Cart Page, Bundle Details).
class CustomPriceSummary extends StatelessWidget {
  const CustomPriceSummary({
    super.key,
    required this.totalItems,
    required this.weightKg,
    required this.price,
    required this.discount,
    required this.total,
  });

  final int totalItems;
  final double weightKg;
  final num price;
  final num discount;
  final num total;

  String _money(num v) => '\$ ${v.toStringAsFixed(2)}';
  String _kg(double v) => '${v % 1 == 0 ? v.toInt() : v.toStringAsFixed(1)} Kg';

  @override
  Widget build(BuildContext context) {
    final label = AppTextStyles.body16Regular.copyWith(
      color: AppColors.textGrey,
    );
    return Column(
      children: [
        CustomSummaryRow(
          label: AppTexts.totalItem,
          value: '$totalItems',
          labelStyle: label,
        ),
        CustomSummaryRow(
          label: AppTexts.weight,
          value: _kg(weightKg),
          labelStyle: label,
        ),
        CustomSummaryRow(
          label: AppTexts.price,
          value: _money(price),
          labelStyle: label,
        ),
        CustomSummaryRow(
          label: AppTexts.discount,
          value: _money(discount),
          labelStyle: label,
        ),
        10.verticalSpace,
        const CustomDashedDivider(),
        10.verticalSpace,
        CustomSummaryRow(
          label: AppTexts.totalPrice,
          value: _money(total),
          labelStyle: label,
          valueStyle: AppTextStyles.body16Bold,
        ),
      ],
    );
  }
}
