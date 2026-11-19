import '../../core/constants/app_assets.dart';
import '../../core/constants/app_texts.dart';
import '../models/category_model.dart';

/// Mock categories (no backend yet). Edit labels in `AppTexts`, icons in
/// `AppAssets`; the order here is the order of the "Choose a Category" grid.
abstract final class CategoryData {
  static const List<CategoryModel> all = [
    CategoryModel(
      type: CategoryType.vegetables,
      name: AppTexts.vegetables,
      icon: AppAssets.icCategoryVegetables,
    ),
    CategoryModel(
      type: CategoryType.meatFish,
      name: AppTexts.meatAndFish,
      icon: AppAssets.icCategoryMeatFish,
    ),
    CategoryModel(
      type: CategoryType.medicine,
      name: AppTexts.medicine,
      icon: AppAssets.icCategoryMedicine,
    ),
    CategoryModel(
      type: CategoryType.babyCare,
      name: AppTexts.babyCare,
      icon: AppAssets.icCategoryBabyCare,
    ),
    CategoryModel(
      type: CategoryType.office,
      name: AppTexts.officeSupplies,
      icon: AppAssets.icCategoryOffice,
    ),
    CategoryModel(
      type: CategoryType.beauty,
      name: AppTexts.beauty,
      icon: AppAssets.icCategoryBeauty,
    ),
    CategoryModel(
      type: CategoryType.gym,
      name: AppTexts.gymEquipment,
      icon: AppAssets.icCategoryGym,
    ),
    CategoryModel(
      type: CategoryType.gardening,
      name: AppTexts.gardeningTools,
      icon: AppAssets.icCategoryGardening,
    ),
    CategoryModel(
      type: CategoryType.petCare,
      name: AppTexts.petCare,
      icon: AppAssets.icCategoryPetCare,
    ),
    CategoryModel(
      type: CategoryType.eyeWears,
      name: AppTexts.eyeWears,
      icon: AppAssets.icCategoryEyeWears,
    ),
    CategoryModel(
      type: CategoryType.pack,
      name: AppTexts.pack,
      icon: AppAssets.icBag,
    ),
    CategoryModel(
      type: CategoryType.other,
      name: AppTexts.other,
      icon: AppAssets.icCategoryOther,
    ),
  ];

  /// Categories that hold single products (everything but "Pack"):
  /// Create My Pack chips.
  static final List<CategoryModel> shelves = all
      .where((c) => c.type != CategoryType.pack)
      .toList(growable: false);
}
