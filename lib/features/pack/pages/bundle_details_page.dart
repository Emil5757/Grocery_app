import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/cart/cart_extension.dart';
import '../../../common/models/pack_model.dart';
import '../../../common/models/product_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_price_summary.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/bundle_item_tile.dart';

/// Summary of a pack the user built in Create My Pack.
class BundleDetailsPage extends StatelessWidget {
  const BundleDetailsPage({super.key, required this.selection});

  final Map<ProductModel, int> selection;

  int get _items => selection.values.fold(0, (s, q) => s + q);
  double get _weight =>
      selection.entries.fold(0, (s, e) => s + e.key.weightKg * e.value);
  num get _price =>
      selection.entries.fold<num>(0, (s, e) => s + e.key.price * e.value);
  num get _discount => _price * PackModel.bundleDiscount;

  void _createPack(BuildContext context) {
    final pack = ProductModel(
      id: 'my_pack_${DateTime.now().millisecondsSinceEpoch}',
      name: AppTexts.myPack,
      unit: selection.keys.map((p) => p.name.split(' ').first).join(','),
      price: _price - _discount,
      image: AppAssets.packBundle1,
      weightKg: _weight,
    );
    context.addToCart(pack);
    Go.replace(context, Pager.cart);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.bundleDetails),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w),
        children: [
          for (final e in selection.entries)
            BundleItemTile(product: e.key, quantity: e.value),
          20.verticalSpace,
          CustomPriceSummary(
            totalItems: _items,
            weightKg: _weight,
            price: _price,
            discount: _discount,
            total: _price - _discount,
          ),
          30.verticalSpace,
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.w, 8.h, 30.w, 20.h),
          child: CustomButton(
            text: AppTexts.createBundlePack,
            onTap: () => _createPack(context),
          ),
        ),
      ),
    );
  }
}
