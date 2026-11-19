import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/cart/cart_extension.dart';
import '../../../common/data/product_data.dart';
import '../../../common/models/category_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_masonry_grid.dart';
import '../../../common/widgets/custom_product_card.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

/// Products of one category ("Vegetables"), from the mock catalogue.
class CategoryProductsPage extends StatelessWidget {
  const CategoryProductsPage({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePadding.w,
          vertical: 24.h,
        ),
        child: CustomMasonryGrid(
          children: [
            for (final p in ProductData.byCategory(category.type))
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
