import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/review_model.dart';
import '../widgets/rating_summary_card.dart';
import '../widgets/review_tile.dart';

/// Rating summary and the review list. The pencil opens Submit Review.
class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final Set<int> _liked = {0};

  @override
  Widget build(BuildContext context) {
    const reviews = ReviewModel.demo;
    return Scaffold(
      appBar: CustomAppBar(
        title: AppTexts.reviewTitle,
        actions: [
          IconButton(
            onPressed: () => Go.to(context, Pager.submitReview),
            icon: Icon(Icons.rate_review_outlined, color: AppColors.textPrimary, size: AppSizes.icon24.r),
          ),
          8.horizontalSpace,
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(AppSizes.pagePadding.w, 30.h, AppSizes.pagePadding.w, 30.h),
        children: [
          const RatingSummaryCard(summary: RatingSummary.demo),
          20.verticalSpace,
          const Divider(),
          for (var i = 0; i < reviews.length; i++)
            ReviewTile(
              review: reviews[i],
              liked: _liked.contains(i),
              onLike: () => setState(() => _liked.contains(i) ? _liked.remove(i) : _liked.add(i)),
              // TODO: open a reply composer once replies exist on the backend.
              onReply: () {},
            ),
        ],
      ),
    );
  }
}
