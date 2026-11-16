import '../../core/constants/app_assets.dart';
import '../../core/constants/app_texts.dart';

/// Product category. Used by the category grid, Create My Pack chips and the
/// filter sheet, so it lives in `common/`.
class CategoryModel {
  const CategoryModel({required this.name, required this.icon});

  final String name;
  final String icon;

  static const List<CategoryModel> all = [
    CategoryModel(
      name: AppTexts.vegetables,
      icon: AppAssets.icCategoryVegetables,
    ),
    CategoryModel(
      name: AppTexts.meatAndFish,
      icon: AppAssets.icCategoryMeatFish,
    ),
    CategoryModel(name: AppTexts.medicine, icon: AppAssets.icCategoryMedicine),
    CategoryModel(name: AppTexts.babyCare, icon: AppAssets.icCategoryBabyCare),
    CategoryModel(
      name: AppTexts.officeSupplies,
      icon: AppAssets.icCategoryOffice,
    ),
    CategoryModel(name: AppTexts.beauty, icon: AppAssets.icCategoryBeauty),
    CategoryModel(name: AppTexts.gymEquipment, icon: AppAssets.icCategoryGym),
    CategoryModel(
      name: AppTexts.gardeningTools,
      icon: AppAssets.icCategoryGardening,
    ),
    CategoryModel(name: AppTexts.petCare, icon: AppAssets.icCategoryPetCare),
    CategoryModel(name: AppTexts.eyeWears, icon: AppAssets.icCategoryEyeWears),
    CategoryModel(name: AppTexts.pack, icon: AppAssets.icBag),
    CategoryModel(name: AppTexts.other, icon: AppAssets.icCategoryOther),
  ];
}
