import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'custom_button.dart';

/// Illustration + title + subtitle + optional button. Covers Empty Cart,
/// Empty wishlist, No order yet, Order Successfully / Failed, Error pages.
class CustomEmptyState extends StatelessWidget {
  const CustomEmptyState({
    super.key,
    required this.image,
    required this.title,
    this.subtitle,
    this.buttonText,
    this.onButtonTap,
  });

  final Widget image;
  final String title;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image,
          32.verticalSpace,
          Text(title, textAlign: TextAlign.center, style: AppTextStyles.headline24Bold),
          if (subtitle != null) ...[
            12.verticalSpace,
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: AppTextStyles.body16Grey.copyWith(color: AppColors.textGrey),
            ),
          ],
          if (buttonText != null) ...[
            40.verticalSpace,
            CustomButton(text: buttonText!, onTap: onButtonTap),
          ],
        ],
      ),
    );
  }
}
