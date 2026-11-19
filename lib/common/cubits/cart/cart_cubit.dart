import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product_model.dart';
import 'cart_state.dart';

/// The basket. Many features add to it (home, category, search, product,
/// pack, wishlist) and cart / checkout read it, so it is app-wide state:
/// provided once above `MaterialApp` in `main.dart`.
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  /// Demo coupon until there is a backend.
  static const String demoCoupon = 'EGROCERY';
  static const double demoCouponRate = 0.15;

  void add(ProductModel product, {int quantity = 1}) {
    final items = [...state.items];
    final index = items.indexWhere((i) => i.product == product);
    if (index == -1) {
      items.add(CartItem(product: product, quantity: quantity));
    } else {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + quantity,
      );
    }
    emit(state.copyWith(items: items));
  }

  void setQuantity(ProductModel product, int quantity) {
    if (quantity <= 0) return remove(product);
    emit(
      state.copyWith(
        items: [
          for (final i in state.items)
            i.product == product ? i.copyWith(quantity: quantity) : i,
        ],
      ),
    );
  }

  void remove(ProductModel product) => emit(
    state.copyWith(
      items: state.items.where((i) => i.product != product).toList(),
    ),
  );

  /// Returns whether the code was accepted.
  bool applyCoupon(String code) {
    final valid = code.trim().toUpperCase() == demoCoupon;
    if (valid) emit(state.copyWith(discountRate: demoCouponRate));
    return valid;
  }

  /// Applies a collected voucher (Coupon Details > Redeem Now).
  void applyDiscount(double rate) => emit(state.copyWith(discountRate: rate));

  void clear() => emit(const CartState());
}
