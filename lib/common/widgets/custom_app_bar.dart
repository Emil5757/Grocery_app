import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_assets.dart';
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
    this.titleStyle,
  });

  /// Toolbar height in design units (Forget / New Password and the Menu
  /// pages use 56).
  final double height;

  /// Defaults to `title20Bold`; the Menu pages use `section18Bold`.
  final TextStyle? titleStyle;
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
      // The design's arrow spans x 19..46, so centre it at 32.5.
      leadingWidth: 65.w,
      leading: showBack
          ? IconButton(
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: onBack ?? () => Go.back(context),
              icon: SvgPicture.asset(AppAssets.icBackArrow, width: 27.w),
            )
          : null,
      title: Text(title, style: titleStyle ?? AppTextStyles.title20Bold),
      actions: actions,
      bottom: showDivider
          ? const PreferredSize(preferredSize: Size.fromHeight(1), child: Divider())
          : null,
    );
  }
}
