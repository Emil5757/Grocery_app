/// Raw design numbers (414 x 896 frame). Scale them at the call site with
/// `.w .h .r .sp` so they stay plain `double`s here.
abstract final class AppSizes {
  static const double designWidth = 414;
  static const double designHeight = 896;

  // Padding
  static const double pagePadding = 20;
  static const double cardPadding = 20;

  // Radii
  static const double radius8 = 8;
  static const double radius12 = 12;
  static const double radius16 = 16;
  static const double radius24 = 24;

  // Heights
  static const double buttonHeight = 60;
  static const double inputHeight = 50;
  static const double appBarHeight = 64;
  static const double counterSize = 34;
  static const double addButtonSize = 28;

  // Icons
  static const double icon20 = 20;
  static const double icon24 = 24;
  static const double icon28 = 28;
}
