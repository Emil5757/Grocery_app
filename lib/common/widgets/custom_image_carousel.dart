import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import 'custom_circle_icon_button.dart';
import 'custom_dots_indicator.dart';

/// Light-green rounded panel with swipeable images, page dots and a heart
/// button (Product Details, Bundle Details).
class CustomImageCarousel extends StatefulWidget {
  const CustomImageCarousel({
    super.key,
    required this.images,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.height = 320,
  });

  /// Asset paths.
  final List<String> images;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final double height;

  @override
  State<CustomImageCarousel> createState() => _CustomImageCarouselState();
}

class _CustomImageCarouselState extends State<CustomImageCarousel> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height.h,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppSizes.radius24.r),
      ),
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) => Padding(
              padding: EdgeInsets.fromLTRB(40.w, 40.h, 40.w, 50.h),
              child: Image.asset(widget.images[i], fit: BoxFit.contain),
            ),
          ),
          Positioned(
            top: 18.h,
            right: 18.w,
            child: CustomCircleIconButton(
              icon: widget.isFavorite ? Icons.favorite : Icons.favorite_border,
              onTap: widget.onFavoriteTap,
              size: 48,
              iconSize: 26,
              backgroundColor: AppColors.white,
              iconColor: widget.isFavorite
                  ? AppColors.error
                  : AppColors.textPrimary,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 18.h,
            child: Center(
              child: CustomDotsIndicator(
                count: widget.images.length,
                currentIndex: _index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
