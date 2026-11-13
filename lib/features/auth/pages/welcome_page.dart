import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';

/// "Welcome to our E-Grocery" with the groceries photo and the two entry
/// buttons ("Login or signup" in the designs).
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppAssets.welcomeBackground, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: AppColors.welcomeGradient,
                  stops: AppColors.welcomeGradientStops,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    90.verticalSpace,
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text.rich(
                        TextSpan(
                          text: '${AppTexts.welcomeTo}\n',
                          style: AppTextStyles.display32Bold,
                          children: [
                            TextSpan(
                              text: AppTexts.eGrocery,
                              style: AppTextStyles.display32Bold.copyWith(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: AppTexts.continueWithEmailOrPhone,
                      // TODO: Go.to(context, Pager.login) once the login page exists.
                      onTap: () {},
                    ),
                    20.verticalSpace,
                    CustomButton(
                      text: AppTexts.createAnAccount,
                      backgroundColor: AppColors.white,
                      textStyle: AppTextStyles.button18Bold.copyWith(color: AppColors.textPrimary),
                      // TODO: Go.to(context, Pager.signUp) once the sign up page exists.
                      onTap: () {},
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
