import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/cubits/cart/cart_extension.dart';
import '../../../common/data/product_data.dart';
import '../../../common/models/product_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_empty_state.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/favorite_tile.dart';

/// "My Favorite List" (Save tab). `onBack` lets the shell switch tabs.
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final List<ProductModel> _items = [...ProductData.favorites];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppTexts.myFavoriteList,
        showBack: widget.onBack != null,
        onBack: widget.onBack,
      ),
      body: _items.isEmpty
          ? CustomEmptyState(
              illustration: SvgPicture.asset(AppAssets.emptyCart, width: 160.r),
              title: AppTexts.emptyWishlist,
              subtitle: AppTexts.emptyWishlistSubtitle,
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w),
              itemCount: _items.length,
              itemBuilder: (_, i) {
                final p = _items[i];
                return FavoriteTile(
                  product: p,
                  onTap: () => Go.to(context, Pager.productDetails(p)),
                  onDelete: () => setState(() => _items.removeAt(i)),
                  onAddToCart: () => context.addToCart(p),
                );
              },
            ),
    );
  }
}
