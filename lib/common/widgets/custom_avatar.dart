import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

/// Round portrait on a soft coloured disc (Review, Submit Review, Profile,
/// Order Tracking shipper). The photo sits at the bottom so shoulders are
/// cropped by the circle, as in the designs.
class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required this.image,
    this.size = 60,
    this.background = AppColors.primaryLight,
  });

  /// Asset path of the portrait.
  final String image;

  /// Design size before scaling.
  final double size;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      alignment: Alignment.bottomCenter,
      child: Image.asset(image, height: size.r * 0.92, fit: BoxFit.cover),
    );
  }
}
