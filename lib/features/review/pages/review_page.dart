import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/review/review_cubit.dart';
import '../../../common/data/review_data.dart';
import '../../../common/models/product_model.dart';
import '../../../common/models/review_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/rating_summary_card.dart';
import '../widgets/review_tile.dart';

/// Rating summary and the review list of [product] (`null` = store
/// reviews). The pencil opens Submit Review; what the user submits shows
/// on top straight away.
class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key, this.product});

  final ProductModel? product;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  /// Liked reviews (identity: the list is rebuilt, the models are not).
  /// The design shows the first mock review already liked.
  final Set<ReviewModel> _liked = {ReviewData.demo.first};

  @override
  Widget build(BuildContext context) {
    final id = widget.product?.id;
    final cubit = context.watch<ReviewCubit>();
    final reviews = cubit.reviewsFor(id);
    return Scaffold(
      appBar: CustomAppBar(
        title: AppTexts.reviewTitle,
        actions: [
          IconButton(
            tooltip: AppTexts.submitReview,
            onPressed: () => Go.to(context, Pager.submitReview(product: widget.product)),
            icon: Icon(Icons.rate_review_outlined, color: AppColors.textPrimary, size: AppSizes.icon24.r),
          ),
          8.horizontalSpace,
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(AppSizes.pagePadding.w, 30.h, AppSizes.pagePadding.w, 30.h),
        children: [
          RatingSummaryCard(summary: cubit.summaryFor(id)),
          20.verticalSpace,
          const Divider(),
          for (final r in reviews)
            ReviewTile(
              review: r,
              liked: _liked.contains(r),
              onLike: () => setState(() => _liked.contains(r) ? _liked.remove(r) : _liked.add(r)),
              // TODO: open a reply composer once replies exist on the backend.
              onReply: () {},
            ),
        ],
      ),
    );
  }
}
