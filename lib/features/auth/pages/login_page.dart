import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_rich_text_action.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/validator_utils.dart';
import '../widgets/auth_header.dart';
import '../widgets/social_outlined_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    context.hideKeyboard();
    if (!_formKey.currentState!.validate()) return;
    // TODO: Go.removeAll(context, Pager.main) once the main page exists.
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  60.verticalSpace,
                  AuthHeader(
                    circleSize: 120,
                    iconWidth: 63,
                    titleStyle: AppTextStyles.headline24BoldTight,
                    gap: 30,
                  ),
                  40.verticalSpace,
                  CustomTextField(
                    label: AppTexts.phoneNumber,
                    controller: _phoneController,
                    validator: ValidatorUtils.phone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    fillColor: AppColors.background,
                    borderColor: AppColors.transparent,
                  ),
                  24.verticalSpace,
                  CustomTextField(
                    label: AppTexts.password,
                    controller: _passwordController,
                    validator: ValidatorUtils.password,
                    textInputAction: TextInputAction.done,
                    isPassword: true,
                    fillColor: AppColors.background,
                    borderColor: AppColors.transparent,
                  ),
                  12.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      // TODO: Go.to(context, Pager.forgetPassword) once it exists.
                      onTap: () {},
                      child: Text(AppTexts.forgetPassword, style: AppTextStyles.body16Regular),
                    ),
                  ),
                  30.verticalSpace,
                  CustomButton(text: AppTexts.login, hasShadow: true, onTap: _login),
                  50.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: SocialOutlinedButton(
                          icon: SvgPicture.asset(AppAssets.icGoogleCircle, width: 30.r),
                          label: AppTexts.google,
                          color: AppColors.google,
                          onTap: () {},
                        ),
                      ),
                      20.horizontalSpace,
                      Expanded(
                        child: SocialOutlinedButton(
                          icon: Container(
                            width: 30.r,
                            height: 30.r,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: AppColors.apple,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(AppAssets.icAppleWhite, width: 13.r),
                          ),
                          label: AppTexts.apple,
                          color: AppColors.apple,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  36.verticalSpace,
                  CustomRichTextAction(
                    text: AppTexts.dontHaveAccount,
                    actionText: AppTexts.signUp,
                    // TODO: Go.replace(context, Pager.signUp) once it exists.
                    onTap: () {},
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
