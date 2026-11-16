import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/cubits/cart/cart_extension.dart';
import '../../../common/models/pack_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_masonry_grid.dart';
import '../../../common/widgets/custom_product_card.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/color_extensions.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

/// Grid of ready-made packs with a floating "Create Own Pack" button.
class PopularPackPage extends StatelessWidget {
  const PopularPackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.popularPack),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              AppSizes.pagePadding.w,
              24.h,
              AppSizes.pagePadding.w,
              120.h,
            ),
            child: CustomMasonryGrid(
              children: [
                for (final pack in PackModel.popular)
                  CustomProductCard(
                    image: Image.asset(pack.image),
                    name: pack.name,
                    unit: pack.contents,
                    price: pack.price,
                    oldPrice: pack.oldPrice,
                    onTap: () => Go.to(context, Pager.packDetails(pack)),
                    onAdd: () => context.addToCart(pack.asProduct),
                  ),
              ],
            ),
          ),
          // White fade + floating button, as in the design.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(26.w, 40.h, 26.w, 20.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white.withValues(alpha: 0),
                    AppColors.white,
                  ],
                  stops: const [0, 0.5],
                ),
              ),
              child: SafeArea(
                top: false,
                child: CustomButton(
                  text: AppTexts.createOwnPack,
                  hasShadow: true,
                  textStyle: AppTextStyles.button16SemiBold,
                  icon: SvgPicture.asset(
                    AppAssets.icBag,
                    height: 20.r,
                    colorFilter: AppColors.white.toColorFilter,
                  ),
                  onTap: () => Go.to(context, Pager.createMyPack),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
