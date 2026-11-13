import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

/// Round icon button: the green "+" on product cards (default) and the white
/// heart on the product image (`backgroundColor: AppColors.white`).
class CustomCircleIconButton extends StatelessWidget {
  const CustomCircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 28,
    this.iconSize,
    this.backgroundColor = AppColors.primary,
    this.iconColor = AppColors.white,
  });

  final IconData icon;
  final VoidCallback? onTap;

  /// Design size before scaling.
  final double size;
  final double? iconSize;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox.square(
          dimension: size.r,
          child: Icon(icon, color: iconColor, size: (iconSize ?? size * 0.6).r),
        ),
      ),
    );
  }
}
