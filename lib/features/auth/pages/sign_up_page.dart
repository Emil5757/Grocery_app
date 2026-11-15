import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_arrow_button.dart';
import '../../../common/widgets/custom_rich_text_action.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/custom_white_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/validator_utils.dart';

/// "Welcome to our grocery shop": Name, Phone Number, Password on a white
/// card over the grey page, "Sign Up" + arrow submit, and the Log In link.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Off until the first submit, then errors update as the user types.
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() {
    context.hideKeyboard();
    if (!_formKey.currentState!.validate()) {
      setState(() => _autovalidate = AutovalidateMode.onUserInteraction);
      return;
    }
    Go.to(context, Pager.numberVerification);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                64.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(left: 14.w),
                  child: Text(AppTexts.welcomeToGroceryShop, style: AppTextStyles.display36BoldTight),
                ),
                44.verticalSpace,
                CustomWhiteCard(
                  radius: 26,
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.cardPadding.w,
                    60.h,
                    AppSizes.cardPadding.w,
                    68.h,
                  ),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidate,
                    child: Column(
                      children: [
                        CustomTextField(
                          label: AppTexts.name,
                          controller: _nameController,
                          validator: ValidatorUtils.required,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                        24.verticalSpace,
                        CustomTextField(
                          label: AppTexts.phoneNumber,
                          controller: _phoneController,
                          validator: ValidatorUtils.phone,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+ ]'))],
                          fillColor: AppColors.background,
                        ),
                        24.verticalSpace,
                        CustomTextField(
                          label: AppTexts.password,
                          controller: _passwordController,
                          validator: ValidatorUtils.password,
                          textInputAction: TextInputAction.done,
                          isPassword: true,
                        ),
                        60.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppTexts.signUpTitle, style: AppTextStyles.headline28Bold),
                            CustomArrowButton(onTap: _signUp),
                          ],
                        ),
                        46.verticalSpace,
                        CustomRichTextAction(
                          text: AppTexts.alreadyHaveAccount,
                          actionText: AppTexts.logIn,
                          onTap: () => Go.replace(context, Pager.login),
                        ),
                      ],
                    ),
                  ),
                ),
                40.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
