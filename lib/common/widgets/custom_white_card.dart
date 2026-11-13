import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

/// The big rounded white panel on a grey page (Log In, Setting, Profile,
/// Number verification).
class CustomWhiteCard extends StatelessWidget {
  const CustomWhiteCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.radius = AppSizes.radius24,
    this.color = AppColors.white,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      padding: padding ?? EdgeInsets.all(AppSizes.cardPadding.r),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius.r),
      ),
      child: child,
    );
  }
}
