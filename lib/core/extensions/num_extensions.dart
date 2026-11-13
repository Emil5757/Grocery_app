extension PriceExtension on num {
  /// 20 -> "$20", 82.25 -> "$82.25" (matches the cart / product designs).
  String get toPrice =>
      this % 1 == 0 ? '\$${toInt()}' : '\$${toStringAsFixed(2)}';
}
