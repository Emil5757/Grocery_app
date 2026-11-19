import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_texts.dart';

class PaymentMethodModel {
  const PaymentMethodModel({
    required this.name,
    this.icon,
    this.needsCard = false,
  });

  final String name;

  /// SVG asset; `null` uses the drawn cash note.
  final String? icon;

  /// Whether the card form is shown and required.
  final bool needsCard;

  static const List<PaymentMethodModel> all = [
    PaymentMethodModel(
      name: AppTexts.masterCard,
      icon: AppAssets.icMasterCard,
      needsCard: true,
    ),
    PaymentMethodModel(name: AppTexts.paypal, icon: AppAssets.icPaypal),
    PaymentMethodModel(name: AppTexts.cashOnDelivery),
  ];
}
