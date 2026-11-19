import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_outlined_button.dart';
import '../../../common/widgets/custom_white_card.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

/// "Congratulatios!" card on a dimmed page after an order is delivered.
class DeliveredPage extends StatelessWidget {
  const DeliveredPage({super.key, this.orderId = '15425050'});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final grey = AppTextStyles.section18Regular.copyWith(color: AppColors.textGrey, height: 1.5);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.dimBackground,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: CustomWhiteCard(
                radius: 34,
                padding: EdgeInsets.fromLTRB(30.w, 50.h, 30.w, 50.h),
                child: Column(
                  children: [
                    SvgPicture.asset(AppAssets.deliveredSuccess, width: 277.r),
                    30.verticalSpace,
                    Text(AppTexts.congratulations, style: AppTextStyles.headline24Bold),
                    16.verticalSpace,
                    Text.rich(
                      TextSpan(
                        text: AppTexts.deliveredPrefix,
                        style: grey,
                        children: [
                          TextSpan(
                            text: AppTexts.orderHash(orderId),
                            style: grey.copyWith(color: AppColors.textPrimary),
                          ),
                          const TextSpan(text: AppTexts.deliveredSuffix),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    50.verticalSpace,
                    CustomButton(
                      text: AppTexts.rateTheProduct,
                      onTap: () => Go.replace(context, Pager.submitReview),
                    ),
                    24.verticalSpace,
                    CustomOutlinedButton(
                      text: AppTexts.browseHome,
                      textStyle: AppTextStyles.button18Bold.copyWith(color: AppColors.primary),
                      onTap: () => Go.removeAll(context, Pager.main),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
