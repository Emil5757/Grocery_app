import 'package:flutter/services.dart';

/// Shared `inputFormatters` lists, so every field of one kind accepts the
/// same characters. Text fields such as Name and Password take none.
abstract final class AppInputFormatters {
  /// Phone numbers: digits only (no +, spaces or letters), at most 15
  /// digits (the longest number `ValidatorUtils.phone` accepts).
  static final List<TextInputFormatter> phone = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(15),
  ];
}
