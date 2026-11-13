import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_text_styles.dart';

/// "Total Item ........ 6" label/value row (Cart, Checkout, Order Details).
class CustomSummaryRow extends StatelessWidget {
  const CustomSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(child: Text(label, style: labelStyle ?? AppTextStyles.body16Grey)),
          Text(value, style: valueStyle ?? AppTextStyles.body16SemiBold),
        ],
      ),
    );
  }
}
