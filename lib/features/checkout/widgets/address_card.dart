import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../data/models/checkout_model.dart';

/// Selectable delivery address with a radio dot.
class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    required this.selected,
    required this.onTap,
  });

  final AddressModel address;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final grey = AppTextStyles.body16Regular.copyWith(
      color: AppColors.textGrey,
    );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizes.cardPadding.r),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLight : AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radius12.r),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? AppColors.primary : AppColors.divider,
              size: AppSizes.icon20.r,
            ),
            20.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address.title, style: AppTextStyles.body16Bold),
                  6.verticalSpace,
                  Text(address.phone, style: grey),
                  6.verticalSpace,
                  Text(address.address, style: grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
