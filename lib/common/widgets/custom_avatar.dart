import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

/// Round portrait on a soft coloured disc (Review, Submit Review, Profile,
/// Order Tracking shipper). The photo sits at the bottom so shoulders are
/// cropped by the circle, as in the designs.
///
/// `photo` (a picked and cropped image) wins over `image` and fills the
/// whole circle.
class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required this.image,
    this.photo,
    this.size = 60,
    this.background = AppColors.primaryLight,
  });

  /// Asset path of the portrait.
  final String image;

  /// Bytes of a user-picked photo.
  final Uint8List? photo;

  /// Design size before scaling.
  final double size;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final bytes = photo;
    return Container(
      width: size.r,
      height: size.r,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      alignment: Alignment.bottomCenter,
      child: bytes != null
          ? Image.memory(
              bytes,
              width: size.r,
              height: size.r,
              fit: BoxFit.cover,
              gaplessPlayback: true,
            )
          : Image.asset(image, height: size.r * 0.92, fit: BoxFit.cover),
    );
  }
}
