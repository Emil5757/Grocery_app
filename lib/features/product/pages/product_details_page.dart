import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/cart/cart_extension.dart';
import '../../../common/models/product_model.dart';
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

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _quantity = 1;
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.productDetails),
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
              images: [p.image, p.image, p.image],
              isFavorite: _favorite,
              onFavoriteTap: () => setState(() => _favorite = !_favorite),
            ),
            30.verticalSpace,
            Text(p.name, style: AppTextStyles.headline24Bold),
            14.verticalSpace,
            Text(
              AppTexts.weightLabel(p.unit),
              style: AppTextStyles.section18Regular,
            ),
            18.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomPriceText(price: p.price, oldPrice: p.oldPrice),
                ),
                CustomQuantityCounter(
                  quantity: _quantity,
                  onChanged: (v) => setState(() => _quantity = v),
                ),
              ],
            ),
            24.verticalSpace,
            Text(AppTexts.productDetails, style: AppTextStyles.section18Bold),
            10.verticalSpace,
            Text(AppTexts.productDescription, style: AppTextStyles.body16Grey),
            16.verticalSpace,
            const Divider(),
            CustomListTile(
              title: AppTexts.review,
              titleStyle: AppTextStyles.section18Bold,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomRatingStars(rating: 5, size: 22),
                  8.horizontalSpace,
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textPrimary,
                    size: AppSizes.icon28.r,
                  ),
                ],
              ),
              onTap: () => Go.to(context, Pager.review),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomCartActionBar(
        buttonText: AppTexts.buyNow,
        onCartTap: () => context.addToCart(p, quantity: _quantity),
        onButtonTap: () {
          context.addToCart(p, quantity: _quantity);
          Go.to(context, Pager.cart);
        },
      ),
    );
  }
}
