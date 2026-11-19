import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/coupon_model.dart';

/// "Offer And Promos" grid of flat-amount promo cards.
class PromosPage extends StatefulWidget {
  const PromosPage({super.key});

  @override
  State<PromosPage> createState() => _PromosPageState();
}

class _PromosPageState extends State<PromosPage> {
  final Set<int> _collected = {};

  @override
  Widget build(BuildContext context) {
    const promos = PromoModel.demo;
    final white = AppColors.white;
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.offerAndPromos),
      body: GridView.builder(
        padding: EdgeInsets.fromLTRB(AppSizes.pagePadding.w, 30.h, AppSizes.pagePadding.w, 30.h),
        itemCount: promos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 20.h,
          mainAxisExtent: 250.h,
        ),
        itemBuilder: (_, i) {
          final p = promos[i];
          final done = _collected.contains(i);
          return Container(
            padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 22.h),
            decoration: BoxDecoration(color: p.color, borderRadius: BorderRadius.circular(AppSizes.radius16.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.title20Bold.copyWith(color: white)),
                4.verticalSpace,
                Text(p.origin, style: AppTextStyles.body16Regular.copyWith(color: white)),
                18.verticalSpace,
                Text(AppTexts.discountLabel, style: AppTextStyles.body16Regular.copyWith(color: white)),
                4.verticalSpace,
                Text(p.discount, style: AppTextStyles.title20Bold.copyWith(color: white)),
                const Spacer(),
                Material(
                  color: AppColors.whiteOverlay,
                  shape: const StadiumBorder(),
                  child: InkWell(
                    onTap: done ? null : () => setState(() => _collected.add(i)),
                    customBorder: const StadiumBorder(),
                    child: SizedBox(
                      width: double.infinity,
                      height: 44.h,
                      child: Center(
                        child: Text(
                          done ? AppTexts.collected : AppTexts.collect,
                          style: AppTextStyles.body16SemiBold.copyWith(color: white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
