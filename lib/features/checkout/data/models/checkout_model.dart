import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_texts.dart';

class AddressModel {
  const AddressModel({
    required this.title,
    required this.phone,
    required this.address,
  });

  final String title;
  final String phone;
  final String address;

  static const List<AddressModel> saved = [
    AddressModel(
      title: AppTexts.homeAddress,
      phone: '(309) 071-9396-939',
      address: '1749 Custom Road, Chhatak',
    ),
    AddressModel(
      title: AppTexts.officeAddress,
      phone: '(309)  071-9396-939',
      address: '152 Nobab Road, Sylhet',
    ),
  ];
}

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
