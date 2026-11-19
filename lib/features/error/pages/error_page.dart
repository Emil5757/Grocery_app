import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_empty_state.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';

/// "404!!! oppss!! something wrong". Also the app's fallback for unknown
/// routes (`onUnknownRoute` in main.dart). `onRetry` defaults to going back.
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.title = AppTexts.cartPage, this.onRetry});

  final String title;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: CustomEmptyState(
        illustration: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The kit's radish photo is missing; carrot is the closest root veg.
            Image.asset(AppAssets.carrot, width: 170.r),
            14.verticalSpace,
            SvgPicture.asset(AppAssets.error404, width: 76.r),
          ],
        ),
        title: AppTexts.somethingWrong,
        subtitle: AppTexts.somethingWrongSubtitle,
        buttonText: AppTexts.tryAgain,
        onButtonTap: onRetry ?? () => Go.back(context),
      ),
    );
  }
}
