import '../../core/constants/app_assets.dart';
import '../models/pack_model.dart';
import 'product_data.dart';

/// Mock packs (no backend yet).
abstract final class PackData {
  /// What every demo pack contains.
  static const List<PackItem> _items = [
    PackItem(product: ProductData.cabbage, kg: 2),
    PackItem(product: ProductData.tomato, kg: 2),
    PackItem(product: ProductData.potato, kg: 2),
    PackItem(product: ProductData.papaya, kg: 2),
    PackItem(product: ProductData.meat, kg: 2),
    PackItem(product: ProductData.tunaFish, kg: 2),
  ];

  /// Home "Popular Pack" row.
  static const List<PackModel> homePacks = [
    PackModel(
      id: 'vegetable_box',
      name: 'Bundle Pack',
      price: 35,
      items: _items,
      image: AppAssets.packVegetableBox,
    ),
    PackModel(
      id: 'fruit_basket',
      name: 'Bundle Pack',
      price: 35,
      items: _items,
      image: AppAssets.packBigFruits,
    ),
  ];

  /// "Popular Pack" page.
  static const List<PackModel> popular = [
    PackModel(
      id: 'medium_spices',
      name: 'Medium Spices Pack',
      price: 35,
      items: _items,
      image: AppAssets.packMediumSpices,
    ),
    PackModel(
      id: 'small_bundle',
      name: 'Small Bundle Pack',
      price: 24,
      items: _items,
      image: AppAssets.packSmallBundle,
    ),
    PackModel(
      id: 'big_vegetable',
      name: 'Big Vegetable Pack',
      price: 12,
      items: _items,
      image: AppAssets.packBigVegetable,
    ),
    PackModel(
      id: 'big_fruits',
      name: 'Big Fruits Pack',
      price: 67,
      items: _items,
      image: AppAssets.packBigFruits,
    ),
    PackModel(
      id: 'small_fruits',
      name: 'Small Fruits Pack',
      price: 38,
      items: _items,
      image: AppAssets.packSmallFruits,
    ),
    PackModel(
      id: 'big_spices',
      name: 'Big Spices Pack',
      price: 89,
      items: _items,
      image: AppAssets.packBigSpices,
    ),
    PackModel(
      id: 'bundle_1',
      name: 'Bundle Pack',
      price: 35,
      items: _items,
      image: AppAssets.packBundle1,
    ),
    PackModel(
      id: 'bundle_2',
      name: 'Bundle Pack',
      price: 24,
      items: _items,
      image: AppAssets.packBundle2,
    ),
  ];
}
