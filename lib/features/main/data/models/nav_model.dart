import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_texts.dart';

/// One bottom-navigation tab. The centre basket button is not a tab: it
/// opens the cart.
class NavModel {
  const NavModel({required this.icon, required this.label});

  final String icon;
  final String label;

  static const List<NavModel> tabs = [
    NavModel(icon: AppAssets.icNavHome, label: AppTexts.navHome),
    NavModel(icon: AppAssets.icNavMenu, label: AppTexts.navMenu),
    NavModel(icon: AppAssets.icNavSave, label: AppTexts.navSave),
    NavModel(icon: AppAssets.icNavProfile, label: AppTexts.navProfile),
  ];
}
