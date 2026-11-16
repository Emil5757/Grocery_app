import '../../models/product_model.dart';

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final ProductModel product;
  final int quantity;

  num get total => product.price * quantity;

  CartItem copyWith({int? quantity}) =>
      CartItem(product: product, quantity: quantity ?? this.quantity);
}

class CartState {
  const CartState({this.items = const [], this.discountRate = 0});

  final List<CartItem> items;

  /// 0..1, set by a valid coupon.
  final double discountRate;

  bool get isEmpty => items.isEmpty;
  int get totalItems => items.fold(0, (sum, i) => sum + i.quantity);
  double get totalWeightKg =>
      items.fold(0, (sum, i) => sum + i.product.weightKg * i.quantity);
  num get subtotal => items.fold<num>(0, (sum, i) => sum + i.total);
  num get discount => subtotal * discountRate;
  num get total => subtotal - discount;

  CartState copyWith({List<CartItem>? items, double? discountRate}) =>
      CartState(
        items: items ?? this.items,
        discountRate: discountRate ?? this.discountRate,
      );
}
