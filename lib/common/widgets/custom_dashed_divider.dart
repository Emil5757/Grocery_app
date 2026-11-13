import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

/// The "- - - - -" line above "Total Price" in the cart summary.
class CustomDashedDivider extends StatelessWidget {
  const CustomDashedDivider({
    super.key,
    this.color = AppColors.textPrimary,
    this.dashWidth = 6,
    this.gap = 4,
    this.thickness = 1,
  });

  final Color color;
  final double dashWidth;
  final double gap;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dash = dashWidth.w;
        final count = (constraints.maxWidth / (dash + gap.w)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (_) => SizedBox(
              width: dash,
              height: thickness,
              child: ColoredBox(color: color),
            ),
          ),
        );
      },
    );
  }
}
