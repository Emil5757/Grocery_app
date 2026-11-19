import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_avatar.dart';
import '../../../common/widgets/custom_rating_stars.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../common/models/review_model.dart';

/// Avatar | name + date, stars, text, Like / Reply.
class ReviewTile extends StatelessWidget {
  const ReviewTile({
    super.key,
    required this.review,
    required this.liked,
    required this.onLike,
    required this.onReply,
  });

  final ReviewModel review;
  final bool liked;
  final VoidCallback onLike;
  final VoidCallback onReply;

  @override
  Widget build(BuildContext context) {
    final grey = AppTextStyles.section18Regular.copyWith(color: AppColors.textGrey);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.h),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAvatar(image: review.avatar, photo: review.photo, background: review.avatarBackground),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(review.name, style: AppTextStyles.title20Regular)),
                    Text(review.date, style: AppTextStyles.label14Grey),
                  ],
                ),
                8.verticalSpace,
                CustomRatingStars(rating: review.rating, size: 20),
                12.verticalSpace,
                Text(review.text, style: AppTextStyles.body16Grey),
                14.verticalSpace,
                Wrap(
                  spacing: 40.w,
                  runSpacing: 8.h,
                  children: [
                    _Action(
                      icon: liked ? Icons.favorite : Icons.favorite_border,
                      iconColor: liked ? AppColors.error : AppColors.textSecondary,
                      label: AppTexts.likes(review.likes + (liked ? 1 : 0)),
                      onTap: onLike,
                    ),
                    _Action(
                      icon: Icons.reply_outlined,
                      iconColor: AppColors.textSecondary,
                      label: AppTexts.reply,
                      onTap: onReply,
                      style: grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
    this.style,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 26.r),
          10.horizontalSpace,
          Text(label, style: style ?? AppTextStyles.section18Regular.copyWith(color: AppColors.textGrey)),
        ],
      ),
    );
  }
}
