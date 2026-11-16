/// Shared UI strings. Feature-only copy can live here too until the app
/// adds localisation (the designs include a Language Setting screen).
abstract final class AppTexts {
  static const String appName = 'eGrocery';
  static const String appSlogan = 'your daily needs';

  // Onboarding
  static const String onboardCategoryTitle = 'Browse all the category';
  static const String onboardDiscountTitle = 'Amazing Discounts & Offers';
  static const String onboardDeliveryTitle = 'Delivery in 30 Min';
  static const String onboardDescription =
      'In aliquip aute exercitation ut et nisi ut mollit. Deserunt dolor elit pariatur aute .';

  // Welcome
  static const String welcomeTo = 'Welcome to our';
  static const String eGrocery = 'E-Grocery';
  static const String continueWithEmailOrPhone = 'Continue with Email or Phone';
  static const String createAnAccount = 'Create an account';

  // Login
  static const String loginWithEmail = 'Login With Email';
  static const String or = 'OR';
  static const String google = 'Google';
  static const String apple = 'Apple';
  static const String forgetPassword = 'Forget Password?';
  static const String dontHaveAccount = 'Don’t Have Account?';

  // Sign up
  static const String welcomeToGroceryShop = 'Welcome to our\ngrocery shop';
  static const String signUpTitle = 'Sign Up';
  static const String alreadyHaveAccount = 'Already Have Account?';

  // Number verification (copy kept as in the design)
  static const String enterYourCode = 'Entry Your 4 digit code';
  static const String didntGetCode = 'Did you don’t get code?';
  static const String codeResent = 'A new code has been sent';
  static const String verified = 'Verified!!';
  static const String verifiedMessage = 'Hurrah!!  You have successfully\nverified the account.';
  static const String browseHome = 'Browse Home';

  // Forget password
  static const String forgetPasswordTitle = 'Forget Password';
  static const String resetYourPassword = 'Reset your password';
  static const String resetPasswordDescription =
      'Please enter your number. We will send a code to your phone to reset your password.';
  static const String sendMeLink = 'Send Me Link';

  // New password
  static const String newPasswordTitle = 'New Password';
  static const String addNewPassword = 'Add New password';
  static const String newPassword = 'New Password';
  static const String retypePassword = 'Retype Password';
  static const String passwordUpdated = 'Your password has been updated';

  // Buttons
  static const String logIn = 'Log In';
  static const String login = 'Login';
  static const String signUp = 'Sign up';
  static const String verify = 'Verify';
  static const String save = 'Save';
  static const String apply = 'Apply';
  static const String buyNow = 'Buy Now';
  static const String checkout = 'Checkout';
  static const String cancel = 'Cancel';
  static const String reset = 'Reset';
  static const String seeAll = 'See All';
  static const String resend = 'Resend';
  static const String done = 'Done';

  // Fields
  static const String name = 'Name';
  static const String phoneNumber = 'Phone Number';
  static const String password = 'Password';
  static const String search = 'Search';

  // Validation
  static const String fieldRequired = 'This field is required';
  static const String invalidPhone = 'Enter a valid phone number';
  static const String passwordTooShort = 'Password must be at least 6 characters';
  static const String passwordsDontMatch = 'Passwords do not match';
  static const String invalidOtp = 'Enter the 4 digit code';
}
