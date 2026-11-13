import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';

/// Green arrow button wrapped in a progress ring that fills 1/3, 2/3, 3/3
/// as the user moves through the slides.
class OnboardNextButton extends StatelessWidget {
  const OnboardNextButton({
    super.key,
    required this.progress,
    required this.onTap,
  });

  /// 0..1
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: progress),
      duration: AppDurations.normal,
      curve: Curves.easeOut,
      builder: (context, value, child) => CustomPaint(
        painter: _RingPainter(
          progress: value,
          trackWidth: 12.r,
          progressWidth: 4.r,
        ),
        child: child,
      ),
      child: SizedBox.square(
        dimension: 88.r,
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: AppColors.shadow, blurRadius: 12.r, offset: Offset(0, 6.r)),
              ],
            ),
            child: Material(
              color: AppColors.primary,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onTap,
                customBorder: const CircleBorder(),
                child: SizedBox.square(
                  dimension: 60.r,
                  child: Icon(Icons.arrow_forward, color: AppColors.white, size: 26.r),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.trackWidth,
    required this.progressWidth,
  });

  final double progress;
  final double trackWidth;
  final double progressWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outer = size.width / 2;

    final track = Paint()
      ..color = AppColors.ringTrack
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackWidth;
    canvas.drawCircle(center, outer - trackWidth / 2, track);

    if (progress <= 0) return;
    final arc = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = progressWidth;
    final radius = outer - progressWidth / 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress.clamp(0, 1),
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.trackWidth != trackWidth ||
      old.progressWidth != progressWidth;
}
