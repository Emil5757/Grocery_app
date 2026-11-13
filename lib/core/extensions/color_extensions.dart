import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  /// For `SvgPicture(colorFilter: AppColors.primary.toColorFilter)`.
  ColorFilter get toColorFilter => ColorFilter.mode(this, BlendMode.srcIn);
}
