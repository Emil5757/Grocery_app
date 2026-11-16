import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/cart/cart_state.dart';
import '../../../common/widgets/custom_quantity_counter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/num_extensions.dart';

/// Image | name, unit, counter | delete + line total.
class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onDelete,
  });

  final CartItem item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final p = item.product;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 80.r, height: 80.r, child: Image.asset(p.image)),
          20.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
                  style: AppTextStyles.section18Regular,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                4.verticalSpace,
                Text(
                  p.unit,
                  style: AppTextStyles.body16Regular.copyWith(
                    color: AppColors.textGrey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                10.verticalSpace,
                CustomQuantityCounter(
                  quantity: item.quantity,
                  min: 0,
                  onChanged: onQuantityChanged,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete_outline,
                  size: AppSizes.icon28.r,
                  color: AppColors.textPrimary,
                ),
              ),
              18.verticalSpace,
              Text(item.total.toPrice, style: AppTextStyles.title20Regular),
            ],
          ),
        ],
      ),
    );
  }
}
