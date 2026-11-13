import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';

/// "Language  >" row with a hairline under it (Setting, Drawer, Help, Recent
/// Searches with a custom `trailing`).
class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    this.onTap,
    this.leading,
    this.trailing,
    this.titleStyle,
    this.showDivider = true,
  });

  final String title;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? titleStyle;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(bottom: BorderSide(color: AppColors.divider))
              : null,
        ),
        child: Row(
          children: [
            if (leading != null) ...[leading!, 14.horizontalSpace],
            Expanded(child: Text(title, style: titleStyle ?? AppTextStyles.body16Regular)),
            trailing ??
                Icon(Icons.chevron_right, color: AppColors.textSecondary, size: AppSizes.icon24.r),
          ],
        ),
      ),
    );
  }
}
