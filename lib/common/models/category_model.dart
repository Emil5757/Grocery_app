/// Which shelf a product sits on. Products point at a category by type, so
/// renaming a category label never breaks the catalogue.
enum CategoryType {
  vegetables,
  meatFish,
  medicine,
  babyCare,
  office,
  beauty,
  gym,
  gardening,
  petCare,
  eyeWears,
  pack,
  other,
}

/// Product category. Used by the category grid, Create My Pack chips and the
/// filter sheet, so it lives in `common/`. The list is in `CategoryData`.
class CategoryModel {
  const CategoryModel({
    required this.type,
    required this.name,
    required this.icon,
  });

  final CategoryType type;
  final String name;

  /// SVG asset drawn in the category circle.
  final String icon;
}
