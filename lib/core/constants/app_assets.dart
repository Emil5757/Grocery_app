/// Every asset path. Add a constant here before using a new file from
/// `assets/icons/` (SVG icons) or `assets/images/` (illustrations, photos).
abstract final class AppAssets {
  static const String _images = 'assets/images';

  // Brand
  static const String logo = '$_images/logo.svg';

  // Onboarding illustrations
  static const String onboardingCategory = '$_images/onboarding_category.svg';
  static const String onboardingDiscount = '$_images/onboarding_discount.svg';
  static const String onboardingSaleBadge = '$_images/onboarding_sale_badge.svg';
  static const String onboardingDelivery = '$_images/onboarding_delivery.svg';

  // Photos
  static const String welcomeBackground = '$_images/welcome_background.png';
}
