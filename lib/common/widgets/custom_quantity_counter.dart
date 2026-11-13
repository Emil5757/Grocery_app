import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_styles.dart';

/// [ - ]  2  [ + ] from Product Details and the Cart. Stateless: the caller
/// owns the value and decides the limits.
class CustomQuantityCounter extends StatelessWidget {
  const CustomQuantityCounter({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.min = 1,
    this.max = 99,
  });

  final int quantity;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CounterButton(
          icon: Icons.remove,
          onTap: quantity > min ? () => onChanged(quantity - 1) : null,
        ),
        SizedBox(
          width: 40.w,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: AppTextStyles.title20Regular,
          ),
        ),
        _CounterButton(
          icon: Icons.add,
          onTap: quantity < max ? () => onChanged(quantity + 1) : null,
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radius8.r);
    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: SizedBox.square(
          dimension: AppSizes.counterSize.r,
          child: Icon(
            icon,
            size: AppSizes.icon20.r,
            color: onTap == null ? AppColors.textGrey : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
