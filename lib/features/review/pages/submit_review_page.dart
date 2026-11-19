import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/review/review_cubit.dart';
import '../../../common/cubits/user/user_cubit.dart';
import '../../../common/models/product_model.dart';
import '../../../common/models/review_model.dart';
import '../../../common/widgets/custom_avatar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_card_scaffold.dart';
import '../../../common/widgets/custom_rating_stars.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';

/// Star rating + comment for [product] (`null` = the store, from
/// Delivered). Posts as the signed-in user into `ReviewCubit`, so it shows
/// on the Review page right away.
class SubmitReviewPage extends StatefulWidget {
  const SubmitReviewPage({super.key, this.product});

  final ProductModel? product;

  @override
  State<SubmitReviewPage> createState() => _SubmitReviewPageState();
}

class _SubmitReviewPageState extends State<SubmitReviewPage> {
  final _comment = TextEditingController();
  int _rating = 0;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  void _submit() {
    context.hideKeyboard();
    if (_rating == 0) {
      context.showSnack(AppTexts.chooseRating);
      return;
    }
    final user = context.read<UserCubit>().state;
    // TODO: send the review once a backend exists.
    context.read<ReviewCubit>().add(
      ReviewModel(
        name: user.fullName,
        avatar: user.avatar,
        photo: user.photo,
        avatarBackground: AppColors.avatarPink,
        date: AppTexts.justNow,
        rating: _rating.toDouble(),
        text: _comment.text.trim(),
        likes: 0,
        productId: widget.product?.id,
        isMine: true,
      ),
    );
    context.showSnack(AppTexts.reviewThanks);
    Go.back(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    return CustomCardScaffold(
      title: AppTexts.submitReview,
      cardPadding: EdgeInsets.fromLTRB(AppSizes.cardPadding.w, 50.h, AppSizes.cardPadding.w, 40.h),
      child: Column(
        children: [
          CustomAvatar(image: user.avatar, photo: user.photo, size: 100, background: AppColors.avatarPink),
          12.verticalSpace,
          Text(user.fullName, style: AppTextStyles.section18Regular),
          36.verticalSpace,
          Text(AppTexts.rateQuestion, textAlign: TextAlign.center, style: AppTextStyles.title20Bold),
          24.verticalSpace,
          CustomRatingStars(
            rating: _rating.toDouble(),
            size: 40,
            onChanged: (v) => setState(() => _rating = v),
          ),
          50.verticalSpace,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(AppTexts.leaveComment, style: AppTextStyles.title20Bold),
          ),
          20.verticalSpace,
          CustomTextField(
            controller: _comment,
            hint: AppTexts.commentHint,
            maxLines: 6,
            keyboardType: TextInputType.multiline,
          ),
          40.verticalSpace,
          CustomButton(text: AppTexts.submit, onTap: _submit),
        ],
      ),
    );
  }
}
