import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_otp_field.dart';
import '../../../common/widgets/custom_rich_text_action.dart';
import '../../../common/widgets/custom_white_card.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/validator_utils.dart';

/// "Number verification": mailbox illustration, four digit boxes, Resend
/// link and Verify. Verify stays disabled until all four digits are in.
class NumberVerificationPage extends StatefulWidget {
  const NumberVerificationPage({super.key});

  @override
  State<NumberVerificationPage> createState() => _NumberVerificationPageState();
}

class _NumberVerificationPageState extends State<NumberVerificationPage> {
  String _code = '';

  bool get _isComplete => ValidatorUtils.otp(_code) == null;

  void _verify() {
    context.hideKeyboard();
    if (!_isComplete) return;
    Go.removeAll(context, Pager.main);
  }

  // TODO: request a new code once a backend exists.
  void _resend() => context.showSnack(AppTexts.codeResent);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 87.h, 16.w, 40.h),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: CustomWhiteCard(
              radius: 26,
              padding: EdgeInsets.fromLTRB(25.w, 54.h, 25.w, 43.h),
              child: Column(
                children: [
                  Text(
                    AppTexts.enterYourCode,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title20Regular,
                  ),
                  20.verticalSpace,
                  Container(
                    width: 240.w,
                    height: 160.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(AppSizes.radius16.r),
                    ),
                    child: SvgPicture.asset(AppAssets.verificationMailbox, width: 100.r),
                  ),
                  60.verticalSpace,
                  CustomOtpField(
                    onChanged: (code) => setState(() => _code = code),
                  ),
                  113.verticalSpace,
                  CustomRichTextAction(
                    text: AppTexts.didntGetCode,
                    actionText: AppTexts.resend,
                    onTap: _resend,
                  ),
                  45.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: CustomButton(
                      text: AppTexts.verify,
                      height: 50.h,
                      onTap: _isComplete ? _verify : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
