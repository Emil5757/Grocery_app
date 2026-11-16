import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'custom_button.dart';

/// Illustration in a light-green circle + title + subtitle + button(s).
/// Covers Empty Cart, No Orders Yet, Order Placed Successfully and
/// Sorry, Order has Failed.
class CustomEmptyState extends StatelessWidget {
  const CustomEmptyState({
    super.key,
    required this.illustration,
    required this.title,
    this.subtitle,
    this.buttonText,
    this.onButtonTap,
    this.secondaryText,
    this.onSecondaryTap,
  });

  /// Usually `SvgPicture.asset(...)`; drawn centred in a 280 circle.
  final Widget illustration;
  final String title;
  final String? subtitle;
  final String? buttonText;
  final VoidCallback? onButtonTap;

  /// Optional green text link under the button ("Track Order").
  final String? secondaryText;
  final VoidCallback? onSecondaryTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 280.r,
            height: 280.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: illustration,
          ),
          30.verticalSpace,
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.headline24Bold,
          ),
          if (subtitle != null) ...[
            12.verticalSpace,
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: AppTextStyles.body16Grey,
            ),
          ],
          if (buttonText != null) ...[
            90.verticalSpace,
            CustomButton(text: buttonText!, onTap: onButtonTap),
          ],
          if (secondaryText != null) ...[
            8.verticalSpace,
            TextButton(
              onPressed: onSecondaryTap,
              child: Text(
                secondaryText!,
                style: AppTextStyles.body16Bold.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
