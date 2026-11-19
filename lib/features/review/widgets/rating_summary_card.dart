import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_rating_stars.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../common/models/review_model.dart';

/// Green "4.5" disc, review count and stars | five green progress bars.
class RatingSummaryCard extends StatelessWidget {
  const RatingSummaryCard({super.key, required this.summary});

  final RatingSummary summary;

  @override
  Widget build(BuildContext context) {
    final grey = AppTextStyles.body16Regular.copyWith(
      color: AppColors.textGrey,
    );
    final maxCount = summary.counts.reduce((a, b) => a > b ? a : b);
    return Row(
      children: [
        SizedBox(
          width: 112.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 76.r,
                height: 76.r,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  summary.averageLabel,
                  style: AppTextStyles.headline24Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              12.verticalSpace,
              // Scale down (never wrap) on narrow screens or large fonts.
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppTexts.reviewsCount(summary.total),
                  style: AppTextStyles.body16Regular,
                ),
              ),
              6.verticalSpace,
              FittedBox(
                fit: BoxFit.scaleDown,
                child: CustomRatingStars(
                  rating: summary.average.roundToDouble(),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
        20.horizontalSpace,
        Expanded(
          child: Column(
            children: [
              for (var i = 0; i < summary.counts.length; i++)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    children: [
                      // Labels and counts never wrap; the bar takes what is left.
                      SizedBox(
                        width: 56.w,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppTexts.starsLabel(5 - i),
                            maxLines: 1,
                            style: grey,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
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
                        width: 32.w,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${summary.counts[i]}',
                            maxLines: 1,
                            style: AppTextStyles.body16Regular,
                          ),
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
