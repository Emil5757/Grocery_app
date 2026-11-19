import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_rating_stars.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/review_model.dart';

/// Green "4.5" disc, review count and stars | five green progress bars.
class RatingSummaryCard extends StatelessWidget {
  const RatingSummaryCard({super.key, required this.summary});

  final RatingSummary summary;

  @override
  Widget build(BuildContext context) {
    final grey = AppTextStyles.section18Regular.copyWith(color: AppColors.textGrey);
    final maxCount = summary.counts.reduce((a, b) => a > b ? a : b);
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 76.r,
              height: 76.r,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              child: Text(
                '${summary.average}',
                style: AppTextStyles.headline24Bold.copyWith(color: AppColors.white),
              ),
            ),
            12.verticalSpace,
            Text(AppTexts.reviewsCount(summary.total), style: AppTextStyles.body16Regular),
            6.verticalSpace,
            CustomRatingStars(rating: summary.average.roundToDouble(), size: 20),
          ],
        ),
        24.horizontalSpace,
        Expanded(
          child: Column(
            children: [
              for (var i = 0; i < summary.counts.length; i++)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    children: [
                      SizedBox(width: 58.w, child: Text(AppTexts.starsLabel(5 - i), style: grey)),
                      8.horizontalSpace,
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: summary.counts[i] / (maxCount * 1.2),
                            minHeight: 7.h,
                            color: AppColors.primary,
                            backgroundColor: AppColors.divider,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      SizedBox(
                        width: 34.w,
                        child: Text(
                          '${summary.counts[i]}',
                          textAlign: TextAlign.end,
                          style: AppTextStyles.section18Regular,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
