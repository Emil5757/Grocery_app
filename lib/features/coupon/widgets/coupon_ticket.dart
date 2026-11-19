import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/coupon_model.dart';

/// Coloured ticket: "41% Off" | dashed line | title, Collect pill, expiry,
/// with a half-circle notch cut into the right edge.
class CouponTicket extends StatelessWidget {
  const CouponTicket({
    super.key,
    required this.coupon,
    required this.collected,
    required this.onCollect,
    this.onTap,
  });

  final CouponModel coupon;
  final bool collected;
  final VoidCallback onCollect;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final white = AppColors.white;
    return GestureDetector(
      onTap: onTap,
      child: ClipPath(
        clipper: _NotchClipper(radius: 22.r, corner: AppSizes.radius16.r),
        child: Container(
          height: 160.h,
          color: coupon.color,
          child: Stack(
            children: [
              if (coupon.pattern != null)
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.12,
                    child: SvgPicture.asset(
                      coupon.pattern!,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                    ),
                  ),
                ),
              Row(
                children: [
                  SizedBox(
                    width: 140.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppTexts.percentOff(coupon.percent),
                          style: AppTextStyles.display36Bold.copyWith(color: white, fontSize: 40.sp, height: 1),
                        ),
                        Text(AppTexts.off, style: AppTextStyles.display32Bold.copyWith(color: white, fontWeight: FontWeight.w400, height: 1)),
                      ],
                    ),
                  ),
                  _DashedLine(color: white),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 14.h, 14.w, 14.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Material(
                              color: white,
                              shape: const StadiumBorder(),
                              child: InkWell(
                                onTap: collected ? null : onCollect,
                                customBorder: const StadiumBorder(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
                                  child: Text(
                                    collected ? AppTexts.collected : AppTexts.collect,
                                    style: AppTextStyles.body16SemiBold.copyWith(
                                      color: collected ? AppColors.textGrey : AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            coupon.title,
                            maxLines: 2,
                            style: AppTextStyles.headline24Bold.copyWith(color: white, height: 1.1),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              AppTexts.expiry(coupon.expiry),
                              style: AppTextStyles.label14Regular.copyWith(color: white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedLine extends StatelessWidget {
  const _DashedLine({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final count = (c.maxHeight / 12).floor();
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            count,
            (_) => Container(width: 1.5, height: 6, color: color),
          ),
        );
      },
    );
  }
}

/// Rounded rectangle with a semicircle bitten out of the right edge.
class _NotchClipper extends CustomClipper<Path> {
  _NotchClipper({required this.radius, required this.corner});

  final double radius;
  final double corner;

  @override
  Path getClip(Size size) {
    final card = Path()
      ..addRRect(RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(corner)));
    final notch = Path()
      ..addOval(Rect.fromCircle(center: Offset(size.width, size.height * 0.5), radius: radius));
    return Path.combine(PathOperation.difference, card, notch);
  }

  @override
  bool shouldReclip(_NotchClipper old) => old.radius != radius || old.corner != corner;
}
