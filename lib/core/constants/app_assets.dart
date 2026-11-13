/// Every asset path. Add a constant here before using a new file from
/// `assets/icons/` (SVG) or `assets/images/` (PNG/JPG).
abstract final class AppAssets {
  static const String _icons = 'assets/icons';
  static const String _images = 'assets/images';

  // Icons (add SVGs exported from the design here)
  // static const String icArrowBack = '$_icons/ic_arrow_back.svg';

  // Images (add product / onboarding illustrations here)
  // static const String imgOnboarding1 = '$_images/onboarding_1.png';

  /// Kept so the folder constants are referenced until real assets land.
  static const List<String> folders = [_icons, _images];
}
