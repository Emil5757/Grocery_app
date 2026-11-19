import 'package:flutter/painting.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';

/// Artwork of a saved card on Payment Option.
enum BankCardStyle { navy, teal }

/// A saved bank card (demo data until there is a backend).
class SavedCardModel {
  const SavedCardModel({
    required this.number,
    required this.holder,
    required this.expiry,
    this.brand = AppTexts.visa,
    this.style = BankCardStyle.navy,
  });

  final String number;
  final String holder;

  /// MM/YY.
  final String expiry;
  final String brand;
  final BankCardStyle style;

  /// "1234 5678 1234 5678": digits in groups of four.
  String get groupedNumber {
    final digits = number.replaceAll(RegExp(r'\s'), '');
    final groups = <String>[
      for (var i = 0; i < digits.length; i += 4)
        digits.substring(i, i + 4 > digits.length ? digits.length : i + 4),
    ];
    return groups.join('  ');
  }

  static const List<SavedCardModel> demo = [
    SavedCardModel(
      number: '1234567812345678',
      holder: 'Dannis Albert',
      expiry: '10/24',
    ),
    SavedCardModel(
      number: '1234567812345678',
      holder: 'Nisha Akter',
      expiry: '08/25',
      style: BankCardStyle.teal,
    ),
  ];
}

/// "Paypal / Mypaypal@gmail.com" rows under Other Payment Option.
/// `icon == null` draws the cash note; `iconColor` tints a one-colour SVG.
class OtherPaymentModel {
  const OtherPaymentModel({
    required this.title,
    required this.subtitle,
    this.icon,
    this.iconColor,
  });

  final String title;
  final String subtitle;
  final String? icon;
  final Color? iconColor;

  static const List<OtherPaymentModel> all = [
    OtherPaymentModel(
      title: AppTexts.paypal,
      subtitle: AppTexts.paypalEmail,
      icon: AppAssets.icPaypal,
    ),
    OtherPaymentModel(
      title: AppTexts.cashOnDelivery,
      subtitle: AppTexts.payInCash,
    ),
    OtherPaymentModel(
      title: AppTexts.applePay,
      subtitle: AppTexts.applePaySite,
      icon: AppAssets.icApple,
      iconColor: AppColors.applePay,
    ),
  ];
}

/// Balance shown on the Add New Card preview (from the design).
abstract final class CardPreviewData {
  static const String balance = r'$3.469.52';
}
