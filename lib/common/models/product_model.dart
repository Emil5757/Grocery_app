import '../../core/constants/app_assets.dart';

/// A single product. Shared by every feature that lists or sells products
/// (home, category, search, pack, wishlist, cart), so it lives in `common/`.
class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.unit,
    required this.price,
    required this.image,
    this.oldPrice,
    this.weightKg = 1,
  });

  final String id;
  final String name;

  /// Shown under the name: "1 Kg", "1000 GM", "Onion,Oil,Salt...".
  final String unit;
  final num price;
  final num? oldPrice;
  final String image;

  /// Used for the cart / bundle weight totals.
  final double weightKg;

  @override
  bool operator ==(Object other) => other is ProductModel && other.id == id;

  @override
  int get hashCode => id.hashCode;

  // ---- Demo catalogue (no backend yet) ----

  static const cauliflower = ProductModel(
    id: 'cauliflower',
    name: 'Cauliflower Form The Garden',
    unit: '1 Kg',
    price: 13,
    image: AppAssets.cauliflower,
  );
  static const potato = ProductModel(
    id: 'potato',
    name: 'Potato',
    unit: '1 Kg',
    price: 12,
    image: AppAssets.potato,
  );
  static const tomato = ProductModel(
    id: 'tomato',
    name: 'Fresh Tomato',
    unit: '1 Kg',
    price: 12,
    image: AppAssets.tomato,
  );
  static const broccoli = ProductModel(
    id: 'broccoli',
    name: 'Cauliflower Bangladeshi',
    unit: '5kg',
    price: 20,
    oldPrice: 30,
    weightKg: 5,
    image: AppAssets.broccoli,
  );
  static const carrot = ProductModel(
    id: 'carrot',
    name: 'Carrot Form The Garden',
    unit: '1 Kg',
    price: 13,
    image: AppAssets.carrot,
  );
  static const papaya = ProductModel(
    id: 'papaya',
    name: 'Papaya',
    unit: '1 Kg',
    price: 17,
    image: AppAssets.papaya,
  );
  static const cabbage = ProductModel(
    id: 'cabbage',
    name: 'Cabbage Form The Garden',
    unit: '1 Kg',
    price: 16,
    image: AppAssets.cabbage,
  );
  static const meat = ProductModel(
    id: 'meat',
    name: 'Meat',
    unit: '1 Kg',
    price: 15,
    image: AppAssets.meat,
  );
  static const tunaFish = ProductModel(
    id: 'tuna_fish',
    name: 'Fresh Sea Tuna Fish',
    unit: '1 Kg',
    price: 14,
    image: AppAssets.tunaFish,
  );
  static const perrysIceCream = ProductModel(
    id: 'perrys_ice_cream',
    name: 'Perry’s Ice Cream Banana',
    unit: '800 Gm',
    price: 13,
    weightKg: 0.8,
    image: AppAssets.perrysIceCream,
  );
  static const vanillaIceCream = ProductModel(
    id: 'vanilla_ice_cream',
    name: 'Vanilla Ice Cream',
    unit: '500 Gm',
    price: 12,
    weightKg: 0.5,
    image: AppAssets.vanillaIceCream,
  );
  static const drypers = ProductModel(
    id: 'drypers',
    name: 'Classic pantz Drypers',
    unit: '1 Box',
    price: 13,
    image: AppAssets.drypers,
  );
  static const oreoBiscuit = ProductModel(
    id: 'oreo_biscuit',
    name: 'Oreo Biscut',
    unit: '1000 GM',
    price: 14,
    image: AppAssets.oreoBiscuit,
  );
  static const foundation = ProductModel(
    id: 'foundation',
    name: 'Treat Love Foundation',
    unit: '750 Ml',
    price: 17,
    weightKg: 0.75,
    image: AppAssets.foundation,
  );
  static const girlGuideBiscuits = ProductModel(
    id: 'girl_guide_biscuits',
    name: 'Girl Guide Biscuits',
    unit: '200 Gm',
    price: 18,
    weightKg: 0.2,
    image: AppAssets.girlGuideBiscuits,
  );
  static const sulphurfreeBura = ProductModel(
    id: 'sulphurfree_bura',
    name: 'Sulphurfree Bura',
    unit: '570 Ml',
    price: 11,
    weightKg: 0.57,
    image: AppAssets.sulphurfreeBura,
  );
  static const arnotts = ProductModel(
    id: 'arnotts',
    name: 'Arnott’s',
    unit: '700 Gm',
    price: 15,
    weightKg: 0.7,
    image: AppAssets.arnotts,
  );

  /// "Vegetables" category / Create My Pack grid.
  static const List<ProductModel> vegetables = [
    cauliflower,
    potato,
    tomato,
    broccoli,
    carrot,
    papaya,
    cabbage,
  ];

  /// Home "Our New Item" preview.
  static const List<ProductModel> homeNewItems = [
    girlGuideBiscuits,
    tomato,
    drypers,
    oreoBiscuit,
  ];

  /// "New Item" page.
  static const List<ProductModel> newItems = [
    perrysIceCream,
    vanillaIceCream,
    meat,
    tunaFish,
    drypers,
    cabbage,
    oreoBiscuit,
    foundation,
  ];

  /// Demo search results.
  static const List<ProductModel> searchResults = [
    cauliflower,
    perrysIceCream,
    potato,
    tomato,
    oreoBiscuit,
    vanillaIceCream,
  ];

  /// "My Favorite List" starting content.
  static const List<ProductModel> favorites = [
    oreoBiscuit,
    sulphurfreeBura,
    cauliflower,
    tomato,
    girlGuideBiscuits,
    arnotts,
  ];
}
