import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_text_styles.dart';
import '../../core/extensions/num_extensions.dart';

/// "~~$30~~  $20": optional struck-through old price followed by the price.
class CustomPriceText extends StatelessWidget {
  const CustomPriceText({
    super.key,
    required this.price,
    this.oldPrice,
    this.priceStyle,
    this.oldPriceStyle,
  });

  final num price;
  final num? oldPrice;
  final TextStyle? priceStyle;
  final TextStyle? oldPriceStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (oldPrice != null) ...[
          Text(oldPrice!.toPrice, style: oldPriceStyle ?? AppTextStyles.oldPrice16),
          12.horizontalSpace,
        ],
        Text(price.toPrice, style: priceStyle ?? AppTextStyles.price28Bold),
      ],
    );
  }
}
