/// Every asset path. Add a constant here before using a new file from
/// `assets/icons/` (SVG icons) or `assets/images/` (illustrations, photos).
abstract final class AppAssets {
  static const String _icons = 'assets/icons';
  static const String _images = 'assets/images';

  // Icons
  static const String icCart = '$_icons/ic_cart.svg';
  static const String icApple = '$_icons/ic_apple.svg';
  static const String icAppleWhite = '$_icons/ic_apple_white.svg';
  static const String icGoogle = '$_icons/ic_google.svg';
  static const String icGoogleCircle = '$_icons/ic_google_circle.svg';
  static const String icTwitter = '$_icons/ic_twitter.svg';
  static const String icFacebook = '$_icons/ic_facebook.svg';

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
