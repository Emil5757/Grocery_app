import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../data/models/order_model.dart';

/// Four dots joined by a line, filled up to the order's step, with the
/// status label under the last filled dot.
class OrderStatusBar extends StatelessWidget {
  const OrderStatusBar({super.key, required this.status});

  final OrderStatus status;

  static const int _steps = 4;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final dot = 16.r;
        final gap = (c.maxWidth - dot) / (_steps - 1);
        final filled = status.step;
        final activeX = (filled - 1) * gap + dot / 2;
        return SizedBox(
          height: 52.h,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: dot / 2,
                right: dot / 2,
                top: dot / 2 - 2.h,
                child: Container(height: 4.h, color: AppColors.divider),
              ),
              Positioned(
                left: dot / 2,
                top: dot / 2 - 2.h,
                child: Container(
                  width: (filled - 1) * gap,
                  height: 4.h,
                  color: status.color,
                ),
              ),
              for (var i = 0; i < _steps; i++)
                Positioned(
                  left: i * gap,
                  child: Container(
                    width: dot,
                    height: dot,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < filled ? status.color : AppColors.divider,
                    ),
                  ),
                ),
              Positioned(
                top: dot + 6.h,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment(
                    (activeX / c.maxWidth) * 2 - 1,
                    0,
                  ),
                  child: Text(
                    status.label,
                    style: AppTextStyles.section18Regular.copyWith(color: status.color),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
