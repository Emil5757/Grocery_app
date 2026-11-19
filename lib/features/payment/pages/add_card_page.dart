import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_switch_tile.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/custom_white_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/utils/validator_utils.dart';
import '../data/models/payment_model.dart';
import '../widgets/card_preview.dart';

/// "Add New Card": live card preview, then name, number, MM/YY, CVV and
/// "Remember" in a white card. Pops with the new [SavedCardModel].
class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _number = TextEditingController();
  final _expiry = TextEditingController();
  final _cvv = TextEditingController();
  bool _remember = true;

  @override
  void dispose() {
    for (final c in [_name, _number, _expiry, _cvv]) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit() {
    context.hideKeyboard();
    if (!_formKey.currentState!.validate()) return;
    // TODO: send to the payment provider; `_remember` decides whether it is
    // stored once a backend exists.
    Go.back(
      context,
      SavedCardModel(
        number: _number.text.replaceAll(RegExp(r'\s'), ''),
        holder: _name.text.trim(),
        expiry: _expiry.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const CustomAppBar(title: AppTexts.addNewCard),
        body: Form(
          key: _formKey,
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(
              AppSizes.pagePadding.w,
              26.h,
              AppSizes.pagePadding.w,
              30.h,
            ),
            children: [
              ListenableBuilder(
                listenable: Listenable.merge([_name, _number]),
                builder: (_, _) => CardPreview(
                  holder: _name.text.trim().isEmpty
                      ? SavedCardModel.demo.first.holder
                      : _name.text.trim(),
                  number: _number.text,
                ),
              ),
              30.verticalSpace,
              CustomWhiteCard(
                radius: AppSizes.radius16,
                padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 30.h),
                child: Column(
                  children: [
                    CustomTextField(
                      label: AppTexts.cardName,
                      controller: _name,
                      validator: ValidatorUtils.required,
                      textInputAction: TextInputAction.next,
                    ),
                    20.verticalSpace,
                    CustomTextField(
                      label: AppTexts.cardNumber,
                      controller: _number,
                      validator: ValidatorUtils.cardNumber,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
                        LengthLimitingTextInputFormatter(23),
                      ],
                    ),
                    20.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: AppTexts.expirationDate,
                            hint: AppTexts.monthYearHint,
                            controller: _expiry,
                            validator: ValidatorUtils.cardExpiry,
                            keyboardType: TextInputType.datetime,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9/]'),
                              ),
                              LengthLimitingTextInputFormatter(5),
                            ],
                          ),
                        ),
                        20.horizontalSpace,
                        Expanded(
                          child: CustomTextField(
                            label: AppTexts.cvv,
                            hint: AppTexts.cvv,
                            controller: _cvv,
                            validator: ValidatorUtils.cvv,
                            keyboardType: TextInputType.number,
                            isPassword: true,
                            showVisibilityToggle: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    CustomSwitchTile(
                      title: AppTexts.rememberCard,
                      value: _remember,
                      showDivider: false,
                      onChanged: (v) => setState(() => _remember = v),
                    ),
                    30.verticalSpace,
                    CustomButton(text: AppTexts.addCard, onTap: _submit),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
