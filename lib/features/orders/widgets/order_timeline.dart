import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../data/models/order_model.dart';

/// Badge | ring on a green line | title, date, time. Steps after
/// `reached` are greyed (Delivery not yet done).
class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key, required this.steps, required this.reached});

  final List<OrderStep> steps;
  final int reached;

  @override
  Widget build(BuildContext context) {
    final grey = AppTextStyles.body16Regular.copyWith(color: AppColors.textGrey);
    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 36.w),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: steps[i].background == null
                      ? SvgPicture.asset(steps[i].icon, width: 40.r, height: 40.r)
                      : Container(
                          width: 40.r,
                          height: 40.r,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: steps[i].background,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: SvgPicture.asset(steps[i].icon, width: 24.r),
                        ),
                ),
                20.horizontalSpace,
                SizedBox(
                  width: 16.r,
                  child: Column(
                    children: [
                      Container(
                        width: 2.5.w,
                        height: 6.h,
                        color: i == 0 ? AppColors.transparent : AppColors.primary,
                      ),
                      Container(
                        width: 14.r,
                        height: 14.r,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 3.r),
                        ),
                      ),
                      Expanded(child: Container(width: 2.5.w, color: AppColors.primary)),
                    ],
                  ),
                ),
                20.horizontalSpace,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[i].title,
                          style: i < reached
                              ? AppTextStyles.section18Regular
                              : AppTextStyles.section18Regular.copyWith(color: AppColors.textGrey),
                        ),
                        6.verticalSpace,
                        Row(
                          children: [
                            Expanded(child: Text(steps[i].date, style: grey)),
                            Text(steps[i].time, style: grey),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
