import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

/// Five yellow stars. Pass `onChanged` to make it a picker (Review page).
class CustomRatingStars extends StatelessWidget {
  const CustomRatingStars({
    super.key,
    required this.rating,
    this.size = 18,
    this.onChanged,
  });

  /// 0..5, halves allowed.
  final double rating;
  final double size;
  final ValueChanged<int>? onChanged;

  IconData _iconFor(int index) => rating > index && rating < index + 1
      ? Icons.star_half_rounded
      : Icons.star_rounded;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final star = Icon(
          _iconFor(i),
          color: rating > i ? AppColors.star : AppColors.starEmpty,
          size: size.r,
        );
        return onChanged == null
            ? star
            : GestureDetector(onTap: () => onChanged!(i + 1), child: star);
      }),
    );
  }
}
