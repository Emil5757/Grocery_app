import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/payment_model.dart';

/// Saved card on Payment Option: brand, grouped number, holder and expiry
/// over two soft blobs (blue + pink on navy, or teal on indigo).
class BankCard extends StatelessWidget {
  const BankCard({
    super.key,
    required this.card,
    this.width = 335,
    this.height = 190,
  });

  final SavedCardModel card;

  /// Design units.
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final navy = card.style == BankCardStyle.navy;
    final white = AppColors.white;
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radius16.r),
      child: SizedBox(
        width: width.w,
        height: height.w,
        child: CustomPaint(
          painter: _BlobPainter(
            background: navy ? AppColors.cardNavy : AppColors.cardIndigo,
            topBlob: navy ? AppColors.cardBlue : AppColors.cardTeal,
            bottomBlob: navy ? AppColors.cardPink : null,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 20.w, 16.w, 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.brand,
                  style: AppTextStyles.headline24Bold.copyWith(
                    color: white,
                    fontSize: 30.sp,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Spacer(),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    card.groupedNumber,
                    style: AppTextStyles.title20SemiBold.copyWith(
                      color: white,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        card.holder.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.section18SemiBold.copyWith(
                          color: white,
                        ),
                      ),
                    ),
                    12.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppTexts.expDate,
                          style: AppTextStyles.label14Medium.copyWith(
                            color: white,
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          card.expiry,
                          style: AppTextStyles.label14Medium.copyWith(
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BlobPainter extends CustomPainter {
  const _BlobPainter({
    required this.background,
    required this.topBlob,
    this.bottomBlob,
  });

  final Color background;
  final Color topBlob;
  final Color? bottomBlob;

  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width, h = s.height;
    canvas.drawRect(Offset.zero & s, Paint()..color = background);

    // Top-left wave: down from the top edge, across, and off the left side.
    final top = Path()
      ..moveTo(0, 0)
      ..lineTo(w * 0.49, 0)
      ..cubicTo(w * 0.45, h * 0.2, w * 0.38, h * 0.24, w * 0.3, h * 0.27)
      ..cubicTo(w * 0.2, h * 0.3, w * 0.17, h * 0.4, w * 0.12, h * 0.55)
      ..cubicTo(w * 0.08, h * 0.66, w * 0.04, h * 0.68, 0, h * 0.68)
      ..close();
    canvas.drawPath(top, Paint()..color = topBlob);

    final bottom = bottomBlob;
    if (bottom == null) return;
    // Bottom-right hill rising to the right edge.
    final hill = Path()
      ..moveTo(w * 0.49, h)
      ..cubicTo(w * 0.48, h * 0.8, w * 0.52, h * 0.75, w * 0.66, h * 0.72)
      ..cubicTo(w * 0.74, h * 0.7, w * 0.74, h * 0.38, w * 0.83, h * 0.3)
      ..cubicTo(w * 0.9, h * 0.25, w * 0.96, h * 0.34, w, h * 0.43)
      ..lineTo(w, h)
      ..close();
    canvas.drawPath(hill, Paint()..color = bottom);
  }

  @override
  bool shouldRepaint(_BlobPainter old) =>
      old.background != background ||
      old.topBlob != topBlob ||
      old.bottomBlob != bottomBlob;
}
