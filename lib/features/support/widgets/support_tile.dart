import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// "Label  >" row with the hairline under it, as on Menu and Help.
///
/// Rows have a fixed height (Menu 64, Help 54) and in both designs the
/// label's centre sits 25 px above the hairline, so the layout holds even
/// when the fallback font's line height differs from Gilroy's.
class SupportTile extends StatelessWidget {
  const SupportTile({
    super.key,
    required this.title,
    required this.onTap,
    this.height = menuHeight,
  });

  static const double menuHeight = 64;
  static const double helpHeight = 54;

  /// Label centre to hairline centre.
  static const double _labelToLine = 25;

  final String title;
  final VoidCallback onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height.h,
        child: Stack(
          children: [
            // A band twice the label offset, sitting on the hairline,
            // centres the row at exactly 25 px above it.
            Positioned(
              left: 0,
              right: 2.w,
              bottom: 0.5.h,
              height: (_labelToLine * 2).h,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body16Regular,
                    ),
                  ),
                  SvgPicture.asset(AppAssets.icChevronRight, width: 9.w),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Divider(height: 1, thickness: 1, color: AppColors.divider),
            ),
          ],
        ),
      ),
    );
  }
}
