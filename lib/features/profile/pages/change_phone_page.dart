import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_card_scaffold.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/utils/validator_utils.dart';

class ChangePhonePage extends StatefulWidget {
  const ChangePhonePage({super.key});

  @override
  State<ChangePhonePage> createState() => _ChangePhonePageState();
}

class _ChangePhonePageState extends State<ChangePhonePage> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  final _retype = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    _retype.dispose();
    super.dispose();
  }

  String? _match(String? value) =>
      ValidatorUtils.phone(value) ?? (value != _phone.text ? AppTexts.phonesDontMatch : null);

  void _update() {
    context.hideKeyboard();
    if (!_formKey.currentState!.validate()) return;
    // TODO: verify the new number with an OTP once a backend exists.
    context.showSnack(AppTexts.phoneUpdated);
    Go.back(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCardScaffold(
      title: AppTexts.changePhoneNumber,
      cardPadding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 60.h),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              label: AppTexts.newPhoneNumber,
              controller: _phone,
              keyboardType: TextInputType.phone,
              validator: ValidatorUtils.phone,
              textInputAction: TextInputAction.next,
            ),
            24.verticalSpace,
            CustomTextField(
              label: AppTexts.retypePhoneNumber,
              controller: _retype,
              keyboardType: TextInputType.phone,
              validator: _match,
            ),
            150.verticalSpace,
            CustomButton(text: AppTexts.updatePhoneNumber, onTap: _update),
          ],
        ),
      ),
    );
  }
}
