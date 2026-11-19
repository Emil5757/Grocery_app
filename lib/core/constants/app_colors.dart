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

  /// Dim behind popups ("Verified!!"): turns #F7F7F7 into #BBBBBB.
  static const Color dialogBarrier = Color(0x3D000000);
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
  static const Color starEmpty = Color(0xFFE0E0E0);
  static const Color ringTrack = Color(0xFFF2F2F2);
  static const Color banner = Color(0xFFD5F0DB);
  static const Color cashNote = Color(0xFF7CAAE0);
  static const Color navShadow = Color(0x14000000);

  // Profile header bubbles
  static const Color headerBubbleLight = Color(0xFF60CC74);
  static const Color headerBubbleSoft = Color(0xFF82CF85);

  // Info pages (Menu, About, FAQ, Terms, Help, Contact). The designs set
  // both fill-opacity and opacity, so the alphas below are the products.
  /// Paragraph grey: #8B8B97 at 0.8 x 0.8.
  static const Color textMuted = Color(0xA38B8B97);
  /// Chevrons and Contact phone numbers: #16162E at 0.7.
  static const Color textPrimary70 = Color(0xB316162E);
  /// Contact e-mail and address.
  static const Color textTertiary = Color(0xFF5C5C6D);
  /// Help search placeholder: #8B8B97 at 0.5 x 0.5.
  static const Color searchHint = Color(0x408B8B97);
  /// Behind the Contact map while it loads.
  static const Color mapBackground = Color(0xFFF1F1F1);

  // Notification circles
  static const Color notifyBlue = Color(0xFF3373F5);
  static const Color notifyPink = Color(0xFFF51B84);
  static const Color notifyGreen = Color(0xFF20BA79);
  static const Color notifyRed = Color(0xFFF72020);

  // Coupon tickets (Offer And Promos)
  static const Color couponIndigo = Color(0xFF3F30BD);
  static const Color couponBlue = Color(0xFF3B8FE9);
  static const Color couponGreen = Color(0xFF30BD82);
  static const Color couponCyan = Color(0xFF11C4DC);

  // Promo cards (Offer And Promos grid)
  static const Color promoPurple = Color(0xFFA24ABF);
  static const Color promoNavy = Color(0xFF0E1155);
  static const Color promoTeal = Color(0xFF137362);
  static const Color promoBlue = Color(0xFF495FFF);
  static const Color promoCrimson = Color(0xFFB03157);
  static const Color promoOrange = Color(0xFFDB6F21);

  /// Translucent white for buttons on coloured cards.
  static const Color whiteOverlay = Color(0x33FFFFFF);

  // Order timeline badge behind the white "processing" glyph
  static const Color processingBadge = Color(0xFFEDC126);

  // Avatar backgrounds (Review, Profile)
  static const Color avatarPink = Color(0xFFFFC4C4);
  static const Color avatarPeach = Color(0xFFFFE4BC);
  static const Color avatarLilac = Color(0xFFEBC0F5);

  /// Grey page behind the Delivered Successful card.
  static const Color dimBackground = Color(0xFFB9B9B9);

  // Map route
  static const Color mapMarkerShadow = Color(0x26000000);

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
