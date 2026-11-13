import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/extensions/num_extensions.dart';
import 'custom_circle_icon_button.dart';

/// Grid card from Search Results / Category / Favorite list: image, name,
/// unit, price and a green "+" button.
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
    this.onTap,
    this.onAdd,
  });

  /// Usually `Image.asset(AppAssets.x)` or `Image.network(url)`.
  final Widget image;
  final String name;
  final String unit;
  final num price;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radius24.r);
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
          padding: EdgeInsets.fromLTRB(14.w, 16.h, 12.w, 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: SizedBox(height: 80.h, child: image)),
              14.verticalSpace,
              Text(name, style: AppTextStyles.body16Regular, maxLines: 2, overflow: TextOverflow.ellipsis),
              4.verticalSpace,
              Text(unit, style: AppTextStyles.label14Grey),
              8.verticalSpace,
              Row(
                children: [
                  Expanded(child: Text(price.toPrice, style: AppTextStyles.price16Bold)),
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
