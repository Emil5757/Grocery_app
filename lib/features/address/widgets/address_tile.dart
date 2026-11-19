import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/address_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

/// Radio | title, street, phone | edit (top) + delete (bottom).
class AddressTile extends StatelessWidget {
  const AddressTile({
    super.key,
    required this.address,
    required this.selected,
    required this.onSelect,
    required this.onEdit,
    required this.onDelete,
  });

  final AddressModel address;
  final bool selected;
  final VoidCallback onSelect;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? AppColors.primary : AppColors.textSecondary,
                size: AppSizes.icon20.r,
              ),
            ),
            22.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address.title, style: AppTextStyles.section18Regular),
                  6.verticalSpace,
                  Text(address.address, style: AppTextStyles.section18Regular.copyWith(color: AppColors.textGrey)),
                  8.verticalSpace,
                  Text(address.phone, style: AppTextStyles.section18Regular),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit_note, color: AppColors.textPrimary, size: AppSizes.icon24.r),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete_outline, color: AppColors.textPrimary, size: AppSizes.icon24.r),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
