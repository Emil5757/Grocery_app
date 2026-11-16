import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/color_extensions.dart';
import '../data/models/nav_model.dart';

/// Home | Menu | (basket) | Save | Profile, with the green basket button
/// sitting in a white bump above the bar.
class MainNavBar extends StatelessWidget {
  const MainNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabTap,
    required this.onBasketTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTabTap;
  final VoidCallback onBasketTap;

  @override
  Widget build(BuildContext context) {
    final tabs = NavModel.tabs;
    Widget tab(int i) => Expanded(
      child: _NavItem(
        model: tabs[i],
        selected: i == currentIndex,
        onTap: () => onTabTap(i),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.navShadow,
            blurRadius: 20.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72.h,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              // White bump behind the basket button.
              Positioned(
                top: -26.r,
                child: Container(
                  width: 88.r,
                  height: 88.r,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.navShadow,
                        blurRadius: 20.r,
                        offset: Offset(0, -4.h),
                      ),
                    ],
                  ),
                ),
              ),
              // Covers the bump's lower shadow so it blends into the bar.
              const Positioned.fill(child: ColoredBox(color: AppColors.white)),
              Row(
                children: [
                  tab(0),
                  tab(1),
                  SizedBox(width: 88.r),
                  tab(2),
                  tab(3),
                ],
              ),
              Positioned(
                top: -18.r,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 16.r,
                        offset: Offset(0, 8.h),
                      ),
                    ],
                  ),
                  child: Material(
                    color: AppColors.primary,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: onBasketTap,
                      customBorder: const CircleBorder(),
                      child: SizedBox.square(
                        dimension: 64.r,
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.icNavBasket,
                            width: 30.r,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.model,
    required this.selected,
    required this.onTap,
  });

  final NavModel model;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textGrey;
    return InkResponse(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            model.icon,
            height: 26.r,
            colorFilter: color.toColorFilter,
          ),
          4.verticalSpace,
          Text(
            model.label,
            style: AppTextStyles.label14Regular.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
