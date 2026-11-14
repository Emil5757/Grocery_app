import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/auth_header.dart';
import '../widgets/social_circle_button.dart';

/// "Login or signup start": logo, Login With Email, OR, social row.
class LoginOptionsPage extends StatelessWidget {
  const LoginOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w),
            child: Column(
              children: [
                const Spacer(flex: 3),
                AuthHeader(
                  circleSize: 140,
                  iconWidth: 77,
                  titleStyle: AppTextStyles.display36Bold,
                  gap: 24,
                ),
                const Spacer(flex: 2),
                CustomButton(
                  text: AppTexts.loginWithEmail,
                  onTap: () => Go.to(context, Pager.login),
                ),
                32.verticalSpace,
                Text(AppTexts.or, style: AppTextStyles.section18SemiBold),
                32.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // TODO: hook up social sign-in once a backend exists.
                      SocialCircleButton(
                        asset: AppAssets.icApple,
                        color: AppColors.apple,
                        onTap: () {},
                      ),
                      SocialCircleButton(
                        asset: AppAssets.icGoogle,
                        color: AppColors.google,
                        iconHeight: 20,
                        onTap: () {},
                      ),
                      SocialCircleButton(
                        asset: AppAssets.icTwitter,
                        color: AppColors.twitter,
                        iconHeight: 25,
                        onTap: () {},
                      ),
                      SocialCircleButton(
                        asset: AppAssets.icFacebook,
                        color: AppColors.facebook,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
