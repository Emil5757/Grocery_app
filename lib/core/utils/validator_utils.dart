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
}
