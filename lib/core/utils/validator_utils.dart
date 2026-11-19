import '../constants/app_texts.dart';

/// `TextFormField.validator` helpers. Each returns `null` when valid.
abstract final class ValidatorUtils {
  static String? required(String? value) =>
      (value == null || value.trim().isEmpty) ? AppTexts.fieldRequired : null;

  static String? phone(String? value) {
    final digits = value?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';
    if (digits.isEmpty) return AppTexts.fieldRequired;
    return digits.length < 9 || digits.length > 15 ? AppTexts.invalidPhone : null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return AppTexts.fieldRequired;
    return value.length < 6 ? AppTexts.passwordTooShort : null;
  }

  static String? Function(String?) confirmPassword(String Function() original) =>
      (value) {
        final error = password(value);
        if (error != null) return error;
        return value != original() ? AppTexts.passwordsDontMatch : null;
      };

  static String? otp(String? value, {int length = 4}) =>
      (value == null || !RegExp('^[0-9]{$length}\$').hasMatch(value))
          ? AppTexts.invalidOtp
          : null;

  static String? cardNumber(String? value) {
    final digits = value?.replaceAll(RegExp(r'\s'), '') ?? '';
    if (digits.isEmpty) return AppTexts.fieldRequired;
    return RegExp(r'^[0-9]{13,19}$').hasMatch(digits) ? null : AppTexts.invalidCardNumber;
  }

  /// DD/MM/YYYY, as in the checkout design ("05/09/2021").
  static String? expiryDate(String? value) {
    if (value == null || value.isEmpty) return AppTexts.fieldRequired;
    return RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value) ? null : AppTexts.invalidExpiry;
  }

  /// MM/YY, as on the Add New Card design.
  static String? cardExpiry(String? value) {
    if (value == null || value.isEmpty) return AppTexts.fieldRequired;
    return RegExp(r'^(0[1-9]|1[0-2])/\d{2}$').hasMatch(value) ? null : AppTexts.invalidCardExpiry;
  }

  static String? cvv(String? value) {
    if (value == null || value.isEmpty) return AppTexts.fieldRequired;
    return RegExp(r'^\d{3,4}$').hasMatch(value) ? null : AppTexts.invalidCvv;
  }
}
