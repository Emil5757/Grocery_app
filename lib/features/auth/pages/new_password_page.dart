import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/validator_utils.dart';
import '../widgets/auth_card_scaffold.dart';

/// "New Password": new password + retype (must match), then Done returns
/// to Log In.
class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _retypeController = TextEditingController();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void dispose() {
    _passwordController.dispose();
    _retypeController.dispose();
    super.dispose();
  }

  void _done() {
    context.hideKeyboard();
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidate = AutovalidateMode.onUserInteraction);
      return;
    }
    // TODO: save the new password once a backend exists.
    context.showSnack(AppTexts.passwordUpdated);
    Go.removeAll(context, Pager.login);
  }

  @override
  Widget build(BuildContext context) {
    return AuthCardScaffold(
      title: AppTexts.newPasswordTitle,
      heading: AppTexts.addNewPassword,
      children: [
        12.verticalSpace,
        Form(
          key: _formKey,
          autovalidateMode: _autovalidate,
          child: Column(
            children: [
              CustomTextField(
                label: AppTexts.newPassword,
                controller: _passwordController,
                validator: ValidatorUtils.password,
                textInputAction: TextInputAction.next,
                isPassword: true,
                showVisibilityToggle: false,
              ),
              24.verticalSpace,
              CustomTextField(
                label: AppTexts.retypePassword,
                controller: _retypeController,
                validator: ValidatorUtils.confirmPassword(() => _passwordController.text),
                textInputAction: TextInputAction.done,
                isPassword: true,
                showVisibilityToggle: false,
              ),
            ],
          ),
        ),
        30.verticalSpace,
        CustomButton(text: AppTexts.done, onTap: _done),
      ],
    );
  }
}
