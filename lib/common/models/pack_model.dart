import '../../core/constants/app_assets.dart';
import 'product_model.dart';

/// One line inside a pack: a product and how many kilos of it.
class PackItem {
  const PackItem({required this.product, required this.kg});

  final ProductModel product;
  final num kg;
}

/// A ready-made bundle ("Popular Pack"). Shared by home and the pack screens.
class PackModel {
  const PackModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.oldPrice = 50.32,
    this.contents = 'Onion,Oil,Salt...',
    this.weightKg = 25,
    this.size = 'Medum',
    this.itemCount = 17,
    this.items = defaultItems,
  });

  final String id;
  final String name;
  final num price;
  final num oldPrice;
  final String image;
  final String contents;
  final double weightKg;
  final String size;
  final int itemCount;
  final List<PackItem> items;

  /// Discount applied when the user builds their own pack.
  static const double bundleDiscount = 0.15;

  /// The pack as a sellable product, so the cart only deals with products.
  ProductModel get asProduct => ProductModel(
    id: 'pack_$id',
    name: name,
    unit: contents,
    price: price,
    oldPrice: oldPrice,
    image: image,
    weightKg: weightKg,
  );

  static const List<PackItem> defaultItems = [
    PackItem(product: ProductModel.cabbage, kg: 2),
    PackItem(product: ProductModel.tomato, kg: 2),
    PackItem(product: ProductModel.potato, kg: 2),
    PackItem(product: ProductModel.papaya, kg: 2),
    PackItem(product: ProductModel.meat, kg: 2),
    PackItem(product: ProductModel.tunaFish, kg: 2),
  ];

  /// Home "Popular Pack" row.
  static const List<PackModel> homePacks = [
    PackModel(
      id: 'vegetable_box',
      name: 'Bundle Pack',
      price: 35,
      image: AppAssets.packVegetableBox,
    ),
    PackModel(
      id: 'fruit_basket',
      name: 'Bundle Pack',
      price: 35,
      image: AppAssets.packBigFruits,
    ),
  ];

  /// "Popular Pack" page.
  static const List<PackModel> popular = [
    PackModel(
      id: 'medium_spices',
      name: 'Medium Spices Pack',
      price: 35,
      image: AppAssets.packMediumSpices,
    ),
    PackModel(
      id: 'small_bundle',
      name: 'Small Bundle Pack',
      price: 24,
      image: AppAssets.packSmallBundle,
    ),
    PackModel(
      id: 'big_vegetable',
      name: 'Big Vegetable Pack',
      price: 12,
      image: AppAssets.packBigVegetable,
    ),
    PackModel(
      id: 'big_fruits',
      name: 'Big Fruits Pack',
      price: 67,
      image: AppAssets.packBigFruits,
    ),
    PackModel(
      id: 'small_fruits',
      name: 'Small Fruits Pack',
      price: 38,
      image: AppAssets.packSmallFruits,
    ),
    PackModel(
      id: 'big_spices',
      name: 'Big Spices Pack',
      price: 89,
      image: AppAssets.packBigSpices,
    ),
    PackModel(
      id: 'bundle_1',
      name: 'Bundle Pack',
      price: 35,
      image: AppAssets.packBundle1,
    ),
    PackModel(
      id: 'bundle_2',
      name: 'Bundle Pack',
      price: 24,
      image: AppAssets.packBundle2,
    ),
  ];
}
