import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../data/models/payment_model.dart';

/// Live preview on Add New Card: holder name, masked number and balance on
/// navy with a green corner, a pink ring and two dots.
class CardPreview extends StatelessWidget {
  const CardPreview({super.key, required this.holder, required this.number});

  final String holder;
  final String number;

  /// "4756 •••• •••• 9018": first and last four digits, the rest as dots.
  static String mask(String number) {
    final d = number.replaceAll(RegExp(r'\D'), '');
    if (d.length < 8) return d.isEmpty ? '•••• •••• •••• ••••' : d;
    return '${d.substring(0, 4)}  ••••  ••••  ${d.substring(d.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radius16.r),
      child: AspectRatio(
        aspectRatio: 374 / 214,
        child: CustomPaint(
          painter: const _PreviewPainter(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 18.w, 20.w, 18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  holder,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headline24Bold.copyWith(color: white),
                ),
                const Spacer(flex: 3),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    mask(number),
                    style: AppTextStyles.section18Bold.copyWith(
                      color: white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  CardPreviewData.balance,
                  style: AppTextStyles.headline24Bold.copyWith(color: white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PreviewPainter extends CustomPainter {
  const _PreviewPainter();

  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width, h = s.height;
    canvas.drawRect(Offset.zero & s, Paint()..color = AppColors.cardNavy);

    // Green corner triangle.
    canvas.drawPath(
      Path()
        ..moveTo(w * 0.575, 0)
        ..lineTo(w, 0)
        ..lineTo(w, h * 0.73)
        ..close(),
      Paint()..color = AppColors.cardGreen,
    );
    canvas.drawCircle(
      Offset(w * 0.76, h * 0.33),
      h * 0.07,
      Paint()..color = AppColors.cardMint,
    );

    // Pink ring rising from the bottom-left corner.
    final centre = Offset(w * 0.08, h * 1.02);
    canvas.drawCircle(centre, h * 0.57, Paint()..color = AppColors.cardPink);
    canvas.drawCircle(centre, h * 0.2, Paint()..color = AppColors.cardNavy);

    // Two overlapping dots bottom-right.
    canvas.drawCircle(
      Offset(w * 0.86, h * 0.83),
      h * 0.08,
      Paint()..color = AppColors.cardDeepGreen,
    );
    canvas.drawCircle(
      Offset(w * 0.8, h * 0.83),
      h * 0.08,
      Paint()..color = AppColors.cardPink,
    );
  }

  @override
  bool shouldRepaint(_PreviewPainter old) => false;
}
