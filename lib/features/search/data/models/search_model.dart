import '../../../../core/constants/app_texts.dart';

/// Static demo data for the search screens.
abstract final class SearchModel {
  static const List<String> recentSearches = [
    'Vegetables',
    'Raduni Lal Morich',
    'ACI Lobon',
    'Meat',
    'Handwash',
    'Dog Dry Food',
    'Chicken',
    'Fruit',
  ];

  static const List<String> sortOptions = [
    AppTexts.popularity,
    AppTexts.priceLowToHigh,
    AppTexts.priceHighToLow,
    AppTexts.newest,
  ];

  /// Filter categories: the first three are shown until "See All".
  static const List<String> categories = [
    AppTexts.officeSupplies,
    AppTexts.gardening,
    AppTexts.vegetables,
    AppTexts.meatAndFish,
    AppTexts.medicine,
    AppTexts.babyCare,
    AppTexts.beauty,
    AppTexts.petCare,
  ];

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

/// What the filter sheet returns.
class FilterResult {
  const FilterResult({
    required this.sortBy,
    required this.minPrice,
    required this.maxPrice,
    required this.categories,
    required this.brands,
    required this.rating,
  });

  final String sortBy;
  final double minPrice;
  final double maxPrice;
  final Set<String> categories;
  final Set<String> brands;
  final int rating;
}
