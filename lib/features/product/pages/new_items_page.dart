import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/cart/cart_extension.dart';
import '../../../common/models/product_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_masonry_grid.dart';
import '../../../common/widgets/custom_product_card.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

/// "New Item" (Home > Our New Item > View All).
class NewItemsPage extends StatelessWidget {
  const NewItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.newItem),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePadding.w,
          vertical: 24.h,
        ),
        child: CustomMasonryGrid(
          children: [
            for (final p in ProductModel.newItems)
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
    );
  }
}
