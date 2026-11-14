import 'package:flutter/material.dart';

/// Every colour in the app. Values were sampled from the design exports in
/// `grocery_app_pages/`.
abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF40AA54);
  static const Color primaryDark = Color(0xFF369147);
  static const Color primaryLight = Color(0xFFE8F7EB);

  // Text
  static const Color textPrimary = Color(0xFF16162E);
  static const Color textSecondary = Color(0xFF323247);
  static const Color textGrey = Color(0xFFA2A2AC);

  // Surfaces
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color background = Color(0xFFF7F7F7);
  static const Color scaffoldGrey = Color(0xFFF2F2F2);
  static const Color divider = Color(0xFFECECEC);
  static const Color border = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFECECEC);
  static const Color overlay = Color(0x66000000);
  static const Color transparent = Colors.transparent;

  // Status (order tracking)
  static const Color confirmed = Color(0xFF4044AA);
  static const Color processing = primary;
  static const Color shipped = Color(0xFFE09605);
  static const Color delivered = primary;
  static const Color error = Color(0xFFFF2020);

  // Social brands
  static const Color apple = Color(0xFF333333);
  static const Color google = Color(0xFFDD4B39);
  static const Color twitter = Color(0xFF55ACEE);
  static const Color facebook = Color(0xFF3B5998);

  // Misc
  static const Color star = Color(0xFFFFC107);
  static const Color ringTrack = Color(0xFFF2F2F2);

  /// Welcome photo fade: clear for the top ~44 %, then down to black.
  static const List<Color> welcomeGradient = [
    Color(0x00FFFFFF),
    Color(0x00FFFFFF),
    Color(0x008F8F8F),
    Color(0xFF000000),
  ];
  static const List<double> welcomeGradientStops = [0, 0.2, 0.44, 1];
  static const Color shadow = Color(0x1A40AA54);
}
