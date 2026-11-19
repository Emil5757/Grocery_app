import 'category_model.dart';

/// A single product. Shared by every feature that lists or sells products
/// (home, category, search, pack, wishlist, cart), so it lives in `common/`.
/// The mock catalogue is in `ProductData`.
class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.unit,
    required this.price,
    required this.image,
    this.category = CategoryType.other,
    this.oldPrice,
    this.weightKg = 1,
    this.description,
    this.rating = 5,
  });

  final String id;
  final String name;

  /// Shown under the name: "1 Kg", "1000 GM", "Onion,Oil,Salt...".
  final String unit;
  final num price;
  final num? oldPrice;

  /// PNG asset path.
  final String image;
  final CategoryType category;

  /// Used for the cart / bundle weight totals.
  final double weightKg;

  /// "Product Details" paragraph; `null` uses the generic copy.
  final String? description;

  /// Stars on Product Details (0..5).
  final double rating;

  @override
  bool operator ==(Object other) => other is ProductModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
