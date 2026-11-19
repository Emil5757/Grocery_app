import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/color_extensions.dart';
import '../data/models/notification_model.dart';

/// Coloured circle icon | bold title, grey body, grey time.
class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.item, required this.onTap});

  final NotificationModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final grey = AppTextStyles.section18Regular.copyWith(color: AppColors.textGrey);
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18.h),
            child: Container(
              width: 50.r,
              height: 50.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: item.color, shape: BoxShape.circle),
              child: item.svg != null
                  ? SvgPicture.asset(item.svg!, width: 24.r, colorFilter: AppColors.white.toColorFilter)
                  : Icon(item.icon, color: AppColors.white, size: 24.r),
            ),
          ),
          20.horizontalSpace,
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: AppTextStyles.section18Bold),
                  6.verticalSpace,
                  Text(item.body, style: grey, maxLines: 2, overflow: TextOverflow.ellipsis),
                  6.verticalSpace,
                  Text(item.time, style: AppTextStyles.body16Regular.copyWith(color: AppColors.textGrey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
