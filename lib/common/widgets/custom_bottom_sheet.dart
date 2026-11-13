import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/navigation/go.dart';

/// Sheet frame from the Filter popup: drag handle, [X] / title / action row,
/// then `child`. Open it with `Go.sheet(context, CustomBottomSheet(...))`.
class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.child,
    this.actionText,
    this.onAction,
  });

  final String title;
  final Widget child;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.pagePadding.w,
          20.h,
          AppSizes.pagePadding.w,
          20.h + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            24.verticalSpace,
            Row(
              children: [
                Material(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppSizes.radius8.r),
                  child: InkWell(
                    onTap: () => Go.back(context),
                    borderRadius: BorderRadius.circular(AppSizes.radius8.r),
                    child: SizedBox.square(
                      dimension: 40.r,
                      child: Icon(Icons.close, color: AppColors.textPrimary, size: AppSizes.icon24.r),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(title, textAlign: TextAlign.center, style: AppTextStyles.title20Bold),
                ),
                SizedBox(
                  width: 60.w,
                  child: actionText == null
                      ? null
                      : GestureDetector(
                          onTap: onAction,
                          child: Text(
                            actionText!,
                            textAlign: TextAlign.end,
                            style: AppTextStyles.section18Regular,
                          ),
                        ),
                ),
              ],
            ),
            24.verticalSpace,
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}
