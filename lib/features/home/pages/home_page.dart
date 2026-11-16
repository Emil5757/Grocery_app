import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/cart/cart_extension.dart';
import '../../../common/models/pack_model.dart';
import '../../../common/models/product_model.dart';
import '../../../common/widgets/custom_masonry_grid.dart';
import '../../../common/widgets/custom_product_card.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/home_banner.dart';
import '../widgets/section_header.dart';

/// Home tab: search, banner, Popular Pack row, Our New Item grid.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w);
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 16.h, bottom: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: padding,
              child: CustomSearchField(
                hint: AppTexts.searchProduct,
                readOnly: true,
                onTap: () => Go.to(context, Pager.search),
              ),
            ),
            20.verticalSpace,
            Padding(
              padding: padding,
              child: HomeBanner(onTap: () => Go.to(context, Pager.popularPack)),
            ),
            24.verticalSpace,
            Padding(
              padding: padding,
              child: SectionHeader(
                title: AppTexts.popularPack,
                onViewAll: () => Go.to(context, Pager.popularPack),
              ),
            ),
            16.verticalSpace,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final pack in PackModel.homePacks) ...[
                    SizedBox(
                      width: 183.w,
                      child: CustomProductCard(
                        image: Image.asset(pack.image),
                        name: pack.name,
                        unit: pack.contents,
                        price: pack.price,
                        oldPrice: pack.oldPrice,
                        onTap: () => Go.to(context, Pager.packDetails(pack)),
                        onAdd: () => context.addToCart(pack.asProduct),
                      ),
                    ),
                    16.horizontalSpace,
                  ],
                ],
              ),
            ),
            24.verticalSpace,
            Padding(
              padding: padding,
              child: SectionHeader(
                title: AppTexts.ourNewItem,
                onViewAll: () => Go.to(context, Pager.newItems),
              ),
            ),
            16.verticalSpace,
            Padding(
              padding: padding,
              child: CustomMasonryGrid(
                children: [
                  for (final p in ProductModel.homeNewItems)
                    CustomProductCard(
                      image: Image.asset(p.image),
                      name: p.name,
                      unit: p.unit,
                      price: p.price,
                      onTap: () => Go.to(context, Pager.productDetails(p)),
                      onAdd: () => context.addToCart(p),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
