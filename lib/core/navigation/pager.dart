import 'package:flutter/material.dart';

import '../../features/auth/pages/forget_password_page.dart';
import '../../features/auth/pages/login_options_page.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/new_password_page.dart';
import '../../features/auth/pages/number_verification_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/auth/pages/welcome_page.dart';
import '../../features/onboarding/pages/onboarding_page.dart';
import '../../features/splash/pages/splash_page.dart';

/// Registry of every destination. Add each new page here as a
/// `static const` (or a getter when it needs a `BlocProvider`).
///
/// Flow: splash -replace-> onboarding -replace-> welcome
///       welcome -to-> loginOptions -to-> login
///       welcome -to-> signUp <-replace-> login
///       signUp -to-> numberVerification (Verify -> "Verified!!" dialog)
///       login -to-> forgetPassword -to-> newPassword -removeAll-> login
abstract final class Pager {
  static const Widget splash = SplashPage();
  static const Widget onboarding = OnboardingPage();
  static const Widget welcome = WelcomePage();
  static const Widget loginOptions = LoginOptionsPage();
  static const Widget login = LoginPage();
  static const Widget signUp = SignUpPage();
  static const Widget numberVerification = NumberVerificationPage();
  static const Widget forgetPassword = ForgetPasswordPage();
  static const Widget newPassword = NewPasswordPage();
}
