import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/cart/cart_extension.dart';
import '../../../common/models/product_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_masonry_grid.dart';
import '../../../common/widgets/custom_product_card.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

/// "Search Results": the query, a count and a staggered product grid.
/// Demo data until there is a backend.
class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key, required this.query});

  final String query;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late final _controller = TextEditingController(text: widget.query);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const results = ProductModel.searchResults;
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.searchResults),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePadding.w,
          vertical: 30.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchField(
              controller: _controller,
              readOnly: true,
              onTap: () => Go.back(context),
            ),
            24.verticalSpace,
            Text(
              AppTexts.productsFound(results.length),
              style: AppTextStyles.title20Regular,
            ),
            20.verticalSpace,
            CustomMasonryGrid(
              children: [
                for (final p in results)
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
          ],
        ),
      ),
    );
  }
}
