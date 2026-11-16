import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/product_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_masonry_grid.dart';
import '../../../common/widgets/custom_product_card.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/pack_category_chips.dart';
import '../widgets/pack_selection_bar.dart';

/// Pick products into your own pack; the green bar shows the running pick.
class CreateMyPackPage extends StatefulWidget {
  const CreateMyPackPage({super.key});

  @override
  State<CreateMyPackPage> createState() => _CreateMyPackPageState();
}

class _CreateMyPackPageState extends State<CreateMyPackPage> {
  final Map<ProductModel, int> _selection = {};
  int _category = 0;
  String _query = '';

  num get _total =>
      _selection.entries.fold<num>(0, (s, e) => s + e.key.price * e.value);

  void _add(ProductModel p) =>
      setState(() => _selection.update(p, (q) => q + 1, ifAbsent: () => 1));

  @override
  Widget build(BuildContext context) {
    final products = ProductModel.vegetables
        .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.createMyPack),
      body: ListView(
        padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w),
            child: CustomSearchField(
              hint: AppTexts.searchProduct,
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          20.verticalSpace,
          PackCategoryChips(
            selected: _category,
            onSelected: (i) => setState(() => _category = i),
          ),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w),
            child: CustomMasonryGrid(
              children: [
                for (final p in products)
                  CustomProductCard(
                    image: Image.asset(p.image),
                    name: p.name,
                    unit: p.unit,
                    price: p.price,
                    onTap: () => _add(p),
                    onAdd: () => _add(p),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _selection.isEmpty
          ? null
          : PackSelectionBar(
              selection: _selection,
              total: _total,
              onNext: () =>
                  Go.to(context, Pager.bundleDetails(Map.of(_selection))),
            ),
    );
  }
}
