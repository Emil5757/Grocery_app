import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// Badge | grey caption over a dark value ("Your Delivery Time / 30 Min").
class TrackingInfoRow extends StatelessWidget {
  const TrackingInfoRow({
    super.key,
    required this.leading,
    required this.caption,
    required this.value,
    this.valueStyle,
    this.trailing,
  });

  final Widget leading;
  final String caption;
  final String value;
  final TextStyle? valueStyle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          SizedBox.square(dimension: 40.r, child: leading),
          20.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(caption, style: AppTextStyles.section18Regular.copyWith(color: AppColors.textGrey)),
                2.verticalSpace,
                Text(value, style: valueStyle ?? AppTextStyles.section18Regular),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
