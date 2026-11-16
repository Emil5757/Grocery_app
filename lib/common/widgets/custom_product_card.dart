import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/extensions/num_extensions.dart';
import 'custom_circle_icon_button.dart';

/// Grid card from Home / Search Results / Vegetables / New Item / Popular
/// Pack: image, name, unit (or pack contents), price (+ optional small
/// struck-through old price) and a green "+" button.
///
/// Takes plain values (not a feature model) so `common/` stays independent
/// of `features/`.
class CustomProductCard extends StatelessWidget {
  const CustomProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.unit,
    required this.price,
    this.oldPrice,
    this.onTap,
    this.onAdd,
  });

  /// Usually `Image.asset(AppAssets.x)`.
  final Widget image;
  final String name;
  final String unit;
  final num price;
  final num? oldPrice;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radius16.r);
    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: const BorderSide(color: AppColors.divider),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: EdgeInsets.fromLTRB(14.w, 14.h, 12.w, 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SizedBox(height: 90.h, child: image),
              ),
              14.verticalSpace,
              Text(
                name,
                style: AppTextStyles.body16Regular,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              4.verticalSpace,
              Text(
                unit,
                style: AppTextStyles.label14Grey,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              8.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(price.toPrice, style: AppTextStyles.price16Bold),
                  if (oldPrice != null) ...[
                    6.horizontalSpace,
                    Text('$oldPrice', style: AppTextStyles.oldPrice12Grey),
                  ],
                  const Spacer(),
                  CustomCircleIconButton(icon: Icons.add, onTap: onAdd),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
