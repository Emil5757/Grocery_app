/// Shared UI strings. Feature-only copy can live here too until the app
/// adds localisation (the designs include a Language Setting screen).
abstract final class AppTexts {
  static const String appName = 'eGrocery';
  static const String appSlogan = 'your daily needs';

  // Buttons
  static const String logIn = 'Log In';
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

  // Fields
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
