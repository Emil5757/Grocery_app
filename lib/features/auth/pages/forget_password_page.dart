import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/input_formatters.dart';
import '../../../core/utils/validator_utils.dart';
import '../widgets/auth_card_scaffold.dart';

/// "Forget Password": explain the reset, take the phone number, send a code.
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _send() {
    context.hideKeyboard();
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidate = AutovalidateMode.onUserInteraction);
      return;
    }
    // TODO: request the reset code once a backend exists.
    Go.to(context, Pager.newPassword);
  }

  @override
  Widget build(BuildContext context) {
    return AuthCardScaffold(
      title: AppTexts.forgetPasswordTitle,
      heading: AppTexts.resetYourPassword,
      children: [
        14.verticalSpace,
        Text(AppTexts.resetPasswordDescription, style: AppTextStyles.body16GreyCompact),
        48.verticalSpace,
        Form(
          key: _formKey,
          autovalidateMode: _autovalidate,
          child: CustomTextField(
            label: AppTexts.phoneNumber,
            controller: _phoneController,
            validator: ValidatorUtils.phone,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: AppInputFormatters.phone,
          ),
        ),
        30.verticalSpace,
        CustomButton(text: AppTexts.sendMeLink, onTap: _send),
      ],
    );
  }
}
