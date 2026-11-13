import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../data/models/onboard_model.dart';

/// Illustration + title + description. This is the part that swipes.
class OnboardSlide extends StatelessWidget {
  const OnboardSlide({super.key, required this.model});

  final OnboardModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Shrinks on short screens so the text and button always fit.
        Expanded(
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: OnboardModel.canvasWidth.w,
              height: OnboardModel.canvasHeight.w,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (final layer in model.layers)
                    Positioned(
                      left: layer.left.w,
                      top: layer.top.w,
                      width: layer.width.w,
                      child: SvgPicture.asset(layer.asset, width: layer.width.w),
                    ),
                ],
              ),
            ),
          ),
        ),
        40.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            children: [
              Text(model.title, textAlign: TextAlign.center, style: AppTextStyles.headline24Bold),
              16.verticalSpace,
              Text(
                model.description,
                textAlign: TextAlign.center,
                style: AppTextStyles.body16Grey.copyWith(color: AppColors.textGrey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
