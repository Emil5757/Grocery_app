import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/navigation/go.dart';

/// White app bar with back arrow, centred bold title and a bottom hairline
/// ("Product Details", "Cart Page", "Setting", ...).
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
    this.actions,
    this.showDivider = true,
    this.height = AppSizes.appBarHeight,
  });

  /// Toolbar height in design units (Forget / New Password use 56).
  final double height;
  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final bool showDivider;

  @override
  Size get preferredSize => Size.fromHeight(height.h + (showDivider ? 1 : 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height.h,
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              onPressed: onBack ?? () => Go.back(context),
              icon: Icon(Icons.arrow_back, size: AppSizes.icon28.r, color: AppColors.textPrimary),
            )
          : null,
      title: Text(title, style: AppTextStyles.title20Bold),
      actions: actions,
      bottom: showDivider
          ? const PreferredSize(preferredSize: Size.fromHeight(1), child: Divider())
          : null,
    );
  }
}
