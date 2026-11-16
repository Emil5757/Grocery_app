import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../models/product_model.dart';
import 'cart_cubit.dart';

extension CartContextExtension on BuildContext {
  /// Adds to the app-wide cart and confirms with a snack bar.
  void addToCart(ProductModel product, {int quantity = 1}) {
    read<CartCubit>().add(product, quantity: quantity);
    showSnack(AppTexts.addedToCart);
  }
}
