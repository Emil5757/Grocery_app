import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_texts.dart';
import '../../core/navigation/go.dart';
import 'custom_button.dart';
import 'custom_outlined_button.dart';

/// Yes / No dialog. Pops `true` on Yes:
/// `final ok = await Go.dialog<bool>(context, CustomConfirmDialog(...));`
class CustomConfirmDialog extends StatelessWidget {
  const CustomConfirmDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radius24.r)),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center, style: AppTextStyles.section18Regular),
            24.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    text: AppTexts.no,
                    onTap: () => Go.back(context, false),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: CustomButton(text: AppTexts.yes, onTap: () => Go.back(context, true)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
