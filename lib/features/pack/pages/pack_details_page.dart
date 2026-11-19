import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/cart/cart_extension.dart';
import '../../../common/models/pack_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_cart_action_bar.dart';
import '../../../common/widgets/custom_image_carousel.dart';
import '../../../common/widgets/custom_list_tile.dart';
import '../../../common/widgets/custom_price_text.dart';
import '../../../common/widgets/custom_quantity_counter.dart';
import '../../../common/widgets/custom_rating_stars.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/pack_item_tile.dart';
import '../widgets/pack_stats_row.dart';

/// "Bundle Details" for a ready-made pack (Bundle Product details design).
class PackDetailsPage extends StatefulWidget {
  const PackDetailsPage({super.key, required this.pack});

  final PackModel pack;

  @override
  State<PackDetailsPage> createState() => _PackDetailsPageState();
}

class _PackDetailsPageState extends State<PackDetailsPage> {
  int _quantity = 1;
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    final pack = widget.pack;
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.bundleDetails),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          AppSizes.pagePadding.w,
          24.h,
          AppSizes.pagePadding.w,
          12.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageCarousel(
              images: [pack.image, pack.image, pack.image],
              height: 320,
              isFavorite: _favorite,
              onFavoriteTap: () => setState(() => _favorite = !_favorite),
            ),
            24.verticalSpace,
            Text(pack.name, style: AppTextStyles.headline24Bold),
            12.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomPriceText(
                    price: pack.price,
                    oldPrice: pack.oldPrice,
                  ),
                ),
                CustomQuantityCounter(
                  quantity: _quantity,
                  onChanged: (v) => setState(() => _quantity = v),
                ),
              ],
            ),
            24.verticalSpace,
            PackStatsRow(pack: pack),
            20.verticalSpace,
            Text(AppTexts.packDetails, style: AppTextStyles.body16Bold),
            10.verticalSpace,
            for (final item in pack.items) PackItemTile(item: item),
            CustomListTile(
              title: AppTexts.review,
              titleStyle: AppTextStyles.body16Bold,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomRatingStars(rating: 5, size: 20),
                  8.horizontalSpace,
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textPrimary,
                    size: AppSizes.icon28.r,
                  ),
                ],
              ),
              onTap: () => Go.to(context, Pager.review(product: pack.asProduct)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomCartActionBar(
        buttonText: AppTexts.buyNow,
        onCartTap: () => context.addToCart(pack.asProduct, quantity: _quantity),
        onButtonTap: () {
          context.addToCart(pack.asProduct, quantity: _quantity);
          Go.to(context, Pager.cart);
        },
      ),
    );
  }
}
