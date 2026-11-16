import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/cart/cart_cubit.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/validator_utils.dart';
import '../data/models/checkout_model.dart';
import '../widgets/address_card.dart';
import '../widgets/payment_card.dart';

/// Address, payment method, card form, Pay Now.
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardName = TextEditingController();
  final _cardNumber = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();
  int _address = 0;
  int _payment = 0;
  bool _remember = true;

  bool get _needsCard => PaymentMethodModel.all[_payment].needsCard;

  @override
  void dispose() {
    for (final c in [_cardName, _cardNumber, _expiry, _cvv]) {
      c.dispose();
    }
    super.dispose();
  }

  void _pay() {
    context.hideKeyboard();
    if (_needsCard && !_formKey.currentState!.validate()) return;
    final cart = context.read<CartCubit>();
    if (cart.state.isEmpty) {
      Go.to(context, Pager.orderFailed);
      return;
    }
    // TODO: call the payment API once a backend exists.
    cart.clear();
    Go.removeAll(context, Pager.orderSuccess);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.checkout),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          children: [
            _padded(
              Row(
                children: [
                  Expanded(
                    child: Text(
                      AppTexts.selectDeliveryAddress,
                      style: AppTextStyles.section18Regular,
                    ),
                  ),
                  GestureDetector(
                    // TODO: Go.to(context, Pager.newAddress) once it exists.
                    onTap: () {},
                    child: Text(
                      AppTexts.addNew,
                      style: AppTextStyles.body16Bold.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            for (var i = 0; i < AddressModel.saved.length; i++) ...[
              _padded(
                AddressCard(
                  address: AddressModel.saved[i],
                  selected: i == _address,
                  onTap: () => setState(() => _address = i),
                ),
              ),
              20.verticalSpace,
            ],
            _padded(
              Text(
                AppTexts.selectPaymentSystem,
                style: AppTextStyles.section18Regular,
              ),
            ),
            16.verticalSpace,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w),
              child: Row(
                children: [
                  for (var i = 0; i < PaymentMethodModel.all.length; i++) ...[
                    PaymentCard(
                      method: PaymentMethodModel.all[i],
                      selected: i == _payment,
                      onTap: () => setState(() => _payment = i),
                    ),
                    20.horizontalSpace,
                  ],
                ],
              ),
            ),
            if (_needsCard) ...[
              24.verticalSpace,
              _padded(
                CustomTextField(
                  label: AppTexts.cardName,
                  controller: _cardName,
                  validator: ValidatorUtils.required,
                  textInputAction: TextInputAction.next,
                ),
              ),
              20.verticalSpace,
              _padded(
                CustomTextField(
                  label: AppTexts.cardNumber,
                  controller: _cardNumber,
                  validator: ValidatorUtils.cardNumber,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
                  ],
                ),
              ),
              20.verticalSpace,
              _padded(
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: AppTexts.expirationDate,
                        hint: '05/09/2021',
                        controller: _expiry,
                        validator: ValidatorUtils.expiryDate,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    20.horizontalSpace,
                    Expanded(
                      child: CustomTextField(
                        label: AppTexts.cvv,
                        controller: _cvv,
                        validator: ValidatorUtils.cvv,
                        keyboardType: TextInputType.number,
                        isPassword: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              _padded(
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppTexts.rememberCard,
                        style: AppTextStyles.section18Regular,
                      ),
                    ),
                    Switch(
                      value: _remember,
                      activeTrackColor: AppColors.primary,
                      thumbColor: const WidgetStatePropertyAll(AppColors.white),
                      onChanged: (v) => setState(() => _remember = v),
                    ),
                  ],
                ),
              ),
            ],
            30.verticalSpace,
            _padded(CustomButton(text: AppTexts.payNow, onTap: _pay)),
          ],
        ),
      ),
    );
  }

  Widget _padded(Widget child) => Padding(
    padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w),
    child: child,
  );
}
