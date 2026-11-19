import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_avatar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/profile_model.dart';

/// Green header with two soft bubbles, back arrow, "Profile", avatar with a
/// camera badge, name and ID.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.user,
    required this.height,
    this.onBack,
    this.onCameraTap,
  });

  final UserModel user;
  final double height;
  final VoidCallback? onBack;
  final VoidCallback? onCameraTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          const Positioned.fill(child: ColoredBox(color: AppColors.primary)),
          Positioned(
            left: -150.r,
            top: -220.r,
            child: _bubble(380.r, AppColors.headerBubbleLight),
          ),
          Positioned(
            right: -120.r,
            top: 160.r,
            child: _bubble(280.r, AppColors.headerBubbleSoft),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                SizedBox(
                  height: 56.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (onBack != null)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: onBack,
                            icon: Icon(Icons.arrow_back, color: AppColors.white, size: 28.r),
                          ),
                        ),
                      Text(
                        AppTexts.profile,
                        style: AppTextStyles.title20Bold.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                24.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Row(
                    children: [
                      _avatar(),
                      18.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.fullName,
                              style: AppTextStyles.headline24Bold.copyWith(color: AppColors.white),
                            ),
                            6.verticalSpace,
                            Text(
                              AppTexts.userId(user.id),
                              style: AppTextStyles.section18Regular.copyWith(color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  Widget _avatar() => Stack(
        clipBehavior: Clip.none,
        children: [
          CustomAvatar(image: user.avatar, size: 90, background: AppColors.avatarPink),
          Positioned(
            right: -6.r,
            bottom: -2.r,
            child: Material(
              color: AppColors.white,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onCameraTap,
                customBorder: const CircleBorder(),
                child: SizedBox.square(
                  dimension: 36.r,
                  child: Icon(Icons.camera_alt_outlined, color: AppColors.primary, size: 20.r),
                ),
              ),
            ),
          ),
        ],
      );
}
