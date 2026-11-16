import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/cubits/cart/cart_cubit.dart';
import '../../../common/cubits/cart/cart_state.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_empty_state.dart';
import '../../../common/widgets/custom_price_summary.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/cart_item_tile.dart';

/// Cart Page, or the "Oppss!" empty state when nothing is in it.
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _coupon = TextEditingController();

  @override
  void initState() {
    super.initState();
    _coupon.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _coupon.dispose();
    super.dispose();
  }

  void _applyCoupon() {
    context.hideKeyboard();
    final ok = context.read<CartCubit>().applyCoupon(_coupon.text);
    context.showSnack(ok ? AppTexts.couponApplied : AppTexts.couponInvalid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.cartPage),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, cart) {
          if (cart.isEmpty) {
            return CustomEmptyState(
              illustration: SvgPicture.asset(AppAssets.emptyCart, width: 165.r),
              title: AppTexts.emptyCartTitle,
              subtitle: AppTexts.emptyCartSubtitle,
              buttonText: AppTexts.startBrowsing,
              onButtonTap: () => Go.back(context),
            );
          }
          final cubit = context.read<CartCubit>();
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w),
            children: [
              for (final item in cart.items)
                CartItemTile(
                  item: item,
                  onQuantityChanged: (q) => cubit.setQuantity(item.product, q),
                  onDelete: () => cubit.remove(item.product),
                ),
              30.verticalSpace,
              Text(AppTexts.addCoupon, style: AppTextStyles.section18Bold),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _coupon,
                      hint: AppTexts.voucherHint,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  16.horizontalSpace,
                  CustomButton(
                    text: AppTexts.apply,
                    width: 120.w,
                    textStyle: AppTextStyles.button18Bold,
                    onTap: _coupon.text.trim().isEmpty ? null : _applyCoupon,
                  ),
                ],
              ),
              24.verticalSpace,
              CustomPriceSummary(
                totalItems: cart.totalItems,
                weightKg: cart.totalWeightKg,
                price: cart.subtotal,
                discount: cart.discount,
                total: cart.total,
              ),
              30.verticalSpace,
              CustomButton(
                text: AppTexts.checkout,
                onTap: () => Go.to(context, Pager.checkout),
              ),
              30.verticalSpace,
            ],
          );
        },
      ),
      backgroundColor: AppColors.white,
    );
  }
}
