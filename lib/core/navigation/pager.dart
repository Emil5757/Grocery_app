/// Registry of every destination. Each page is added here as a
/// `static const` (or a getter when it needs a `BlocProvider`) once it exists.
///
/// Planned order, from the designs:
///   splash -> onboarding -> loginOrSignup -> login / signUp
///   -> numberVerification -> main (home | category | wishlist | profile)
abstract final class Pager {
  // static const Widget splash = SplashPage();
}
