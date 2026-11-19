import '../../../../common/data/product_data.dart';
import '../../../../common/models/category_model.dart';
import '../../../../common/models/product_model.dart';
import '../../../../core/constants/app_texts.dart';

enum SortOption {
  popularity(AppTexts.popularity),
  priceLowToHigh(AppTexts.priceLowToHigh),
  priceHighToLow(AppTexts.priceHighToLow),
  newest(AppTexts.newest);

  const SortOption(this.label);

  final String label;
}

/// A filter chip on the sheet: short label from the design + the shelf it
/// filters.
class FilterCategory {
  const FilterCategory(this.label, this.type);

  final String label;
  final CategoryType type;
}

/// Static config for the search screens.
abstract final class SearchModel {
  /// Filter categories: the first three are shown until "See All".
  static const List<FilterCategory> categories = [
    FilterCategory(AppTexts.officeSupplies, CategoryType.office),
    FilterCategory(AppTexts.gardening, CategoryType.gardening),
    FilterCategory(AppTexts.vegetables, CategoryType.vegetables),
    FilterCategory(AppTexts.meatAndFish, CategoryType.meatFish),
    FilterCategory(AppTexts.medicine, CategoryType.medicine),
    FilterCategory(AppTexts.babyCare, CategoryType.babyCare),
    FilterCategory(AppTexts.beauty, CategoryType.beauty),
    FilterCategory(AppTexts.petCare, CategoryType.petCare),
    FilterCategory(AppTexts.gymEquipment, CategoryType.gym),
    FilterCategory(AppTexts.eyeWears, CategoryType.eyeWears),
    FilterCategory(AppTexts.other, CategoryType.other),
  ];

  /// Shown as in the design. Mock products carry no brand yet, so the brand
  /// choice does not narrow the results.
  static const List<String> brands = [
    AppTexts.any,
    AppTexts.square,
    AppTexts.aciLimited,
    'Pran',
    'Fresh',
    'Unilever',
  ];

  static const double minPrice = 0;
  static const double maxPrice = 100;
}

/// What the filter sheet returns, and how it narrows a product list.
class FilterResult {
  const FilterResult({
    this.sortBy = SortOption.popularity,
    this.minPrice = SearchModel.minPrice,
    this.maxPrice = SearchModel.maxPrice,
    this.categories = const {},
    this.brands = const {AppTexts.any},
    this.rating = 0,
  });

  /// No filtering, popularity order.
  static const none = FilterResult();

  final SortOption sortBy;
  final double minPrice;
  final double maxPrice;

  /// Empty = every category.
  final Set<CategoryType> categories;
  final Set<String> brands;

  /// Minimum stars; 0 = any.
  final int rating;

  /// How many filters differ from [none] (sort order not counted).
  int get activeCount =>
      (minPrice > SearchModel.minPrice || maxPrice < SearchModel.maxPrice ? 1 : 0) +
      (categories.isEmpty ? 0 : 1) +
      (rating > 0 ? 1 : 0);

  /// Name search + filters + sort over the mock catalogue.
  List<ProductModel> apply(String query, {Iterable<ProductModel> from = ProductData.all}) {
    final order = {for (final (i, p) in from.indexed) p.id: i};
    final list = ProductData.search(query, from: from)
        .where((p) =>
            p.price >= minPrice &&
            p.price <= maxPrice &&
            (categories.isEmpty || categories.contains(p.category)) &&
            p.rating >= rating)
        .toList();
    int byOrder(ProductModel a, ProductModel b) => order[a.id]!.compareTo(order[b.id]!);
    switch (sortBy) {
      case SortOption.popularity:
        list.sort((a, b) {
          final r = b.rating.compareTo(a.rating);
          return r != 0 ? r : byOrder(a, b);
        });
      case SortOption.priceLowToHigh:
        list.sort((a, b) {
          final r = a.price.compareTo(b.price);
          return r != 0 ? r : byOrder(a, b);
        });
      case SortOption.priceHighToLow:
        list.sort((a, b) {
          final r = b.price.compareTo(a.price);
          return r != 0 ? r : byOrder(a, b);
        });
      case SortOption.newest:
        // The catalogue lists older shelves first; newest = last added.
        list.sort((a, b) => byOrder(b, a));
    }
    return list;
  }
}
