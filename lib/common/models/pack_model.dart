import 'category_model.dart';
import 'product_model.dart';

/// One line inside a pack: a product and how many kilos of it.
class PackItem {
  const PackItem({required this.product, required this.kg});

  final ProductModel product;
  final num kg;
}

/// A ready-made bundle ("Popular Pack"). Shared by home and the pack screens.
/// The mock packs are in `PackData`.
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
    this.items = const [],
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
    category: CategoryType.pack,
  );
}
