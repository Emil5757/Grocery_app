import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

/// Brand-coloured outlined button with a round icon and label
/// ("Google" / "Apple" on the Login screen).
class SocialOutlinedButton extends StatelessWidget {
  const SocialOutlinedButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radius16.r);
    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: color, width: 1.2),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: SizedBox(
          height: AppSizes.buttonHeight.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              14.horizontalSpace,
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.title20SemiBold.copyWith(color: color, letterSpacing: 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
