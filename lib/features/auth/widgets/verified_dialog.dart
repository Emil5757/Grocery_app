import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';

/// "Verified!!" popup shown over Number verification: green tick in a
/// light-green circle with confetti dots, message and "Browse Home".
///
/// Open with `Go.dialog(context, VerifiedDialog(onBrowseHome: ...),
/// dismissible: false, barrierColor: AppColors.dialogBarrier)`.
class VerifiedDialog extends StatelessWidget {
  const VerifiedDialog({super.key, required this.onBrowseHome});

  final VoidCallback onBrowseHome;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
      // Sits a little below centre, so the page title stays visible above it.
      alignment: const Alignment(0, 0.24),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 60.h, 25.w, 60.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              foregroundPainter: _ConfettiPainter(scale: 1.r),
              child: Container(
                width: 160.r,
                height: 160.r,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(AppAssets.icVerifiedCheck, width: 65.r),
              ),
            ),
            48.verticalSpace,
            Text(AppTexts.verified, style: AppTextStyles.headline24Bold),
            16.verticalSpace,
            Text(
              AppTexts.verifiedMessage,
              textAlign: TextAlign.center,
              style: AppTextStyles.body16GreyCompact,
            ),
            46.verticalSpace,
            CustomButton(text: AppTexts.browseHome, onTap: onBrowseHome),
          ],
        ),
      ),
    );
  }
}

/// Green dots scattered around the circle, traced from the design.
/// Offsets are from the circle centre in design units; `big` dots are larger.
class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.scale});

  final double scale;

  static const List<(int, int, bool)> _dots = [
    (-96, -85, false), (-93, -82, false), (-83, -76, false), (-34, -86, false),
    (-31, -79, false), (-16, -83, false), (4, -80, false), (33, -84, false),
    (48, -76, false), (90, -83, false), (96, -78, false), (109, -83, false),
    (107, -65, false), (-89, -67, false), (-93, -63, false), (-99, -59, false),
    (-87, -56, false), (-81, -64, false), (-78, -60, false), (-58, -70, false),
    (-45, -77, true), (-55, -61, false), (77, -58, true), (-103, -41, false),
    (88, -34, false), (-106, -19, false), (-93, -17, false), (-83, -11, true),
    (79, -13, false), (-94, 4, false), (-84, 4, false), (86, 17, true),
    (-86, 17, false), (74, 33, false), (-84, 36, false), (73, 47, true),
    (82, 53, false), (89, 49, false), (-91, 54, false), (-58, 61, true),
    (-68, 70, false), (36, 71, false), (46, 70, false), (62, 69, true),
    (72, 81, false), (-98, 81, false), (-44, 91, false), (10, 93, false),
    (42, 96, false), (53, 93, true), (60, 97, false), (66, 91, true),
    (24, 106, false), (-8, 107, true), (6, 116, true), (-102, 116, false),
    (-82, 114, false), (75, 113, false), (-53, 142, false), (-15, 138, false),
    (10, 134, false), (38, 156, true), (47, 154, false),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final paint = Paint()..color = AppColors.primary;
    for (final (dx, dy, big) in _dots) {
      canvas.drawCircle(
        center + Offset(dx * scale, dy * scale),
        (big ? 1.6 : 0.8) * scale,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.scale != scale;
}
