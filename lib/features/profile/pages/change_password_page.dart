import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_card_scaffold.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/utils/validator_utils.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _new = TextEditingController();
  final _retype = TextEditingController();

  @override
  void dispose() {
    _current.dispose();
    _new.dispose();
    _retype.dispose();
    super.dispose();
  }

  void _update() {
    context.hideKeyboard();
    if (!_formKey.currentState!.validate()) return;
    // TODO: send to the backend once it exists.
    context.showSnack(AppTexts.passwordUpdated);
    Go.back(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCardScaffold(
      title: AppTexts.changePasswordTitle,
      cardPadding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 60.h),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              label: AppTexts.currentPassword,
              controller: _current,
              isPassword: true,
              validator: ValidatorUtils.password,
              textInputAction: TextInputAction.next,
            ),
            24.verticalSpace,
            CustomTextField(
              label: AppTexts.newPassword,
              controller: _new,
              isPassword: true,
              validator: ValidatorUtils.password,
              textInputAction: TextInputAction.next,
            ),
            24.verticalSpace,
            CustomTextField(
              label: AppTexts.retypePasswordField,
              controller: _retype,
              isPassword: true,
              validator: ValidatorUtils.confirmPassword(() => _new.text),
            ),
            50.verticalSpace,
            CustomButton(text: AppTexts.updatePassword, onTap: _update),
          ],
        ),
      ),
    );
  }
}
