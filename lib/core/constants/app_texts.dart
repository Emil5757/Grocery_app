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

  // Navigation
  static const String navHome = 'Home';
  static const String navMenu = 'Menu';
  static const String navSave = 'Save';
  static const String navProfile = 'Profile';

  // Home
  static const String bannerTitle = 'Order your\nDaily Groceries';
  static const String freeDelivery = '#Free Delivery';
  static const String popularPack = 'Popular Pack';
  static const String ourNewItem = 'Our New Item';
  static const String viewAll = 'View All';
  static const String newItem = 'New Item';
  static const String searchProduct = 'Search Product';

  // Category
  static const String chooseCategory = 'Choose a Category';
  static const String vegetables = 'Vegetables';
  static const String meatAndFish = 'Meat & Fish';
  static const String medicine = 'Medicine';
  static const String babyCare = 'Baby Care';
  static const String officeSupplies = 'Office Supplies';
  static const String beauty = 'Beauty';
  static const String gymEquipment = 'Gym Equipment';
  static const String gardeningTools = 'Gardening Tools';
  static const String petCare = 'Pet Care';
  static const String eyeWears = 'Eye Wears';
  static const String pack = 'Pack';
  static const String other = 'Other';

  // Search & filter
  static const String recentSearches = 'Recent Searches';
  static const String searchResults = 'Search Results';
  static String productsFound(int count) => '$count Products Found';
  static const String filter = 'Filter';
  static const String sortBy = 'Sort By';
  static const String popularity = 'Popularity';
  static const String priceLowToHigh = 'Price: Low to High';
  static const String priceHighToLow = 'Price: High to Low';
  static const String newest = 'Newest';
  static const String priceRange = 'Price range';
  static const String categories = 'Categories';
  static const String brand = 'Brand';
  static const String ratingStar = 'Rating Star';
  static const String applyFilter = 'Apply Filter';
  static const String any = 'Any';
  static const String square = 'Square';
  static const String aciLimited = 'ACI Limited';
  static const String gardening = 'Gardening';
  static String dollars(num value) => '${value.round()}\$';

  // Product
  static const String productDetails = 'Product Details';
  static const String bundleDetails = 'Bundle Details';
  static const String review = 'Review';
  static String weightLabel(String unit) => 'Weight: $unit';
  static const String productDescription =
      'Duis aute veniam veniam qui aliquip irure duis sint magna occaecat dolore nisi culpa do. '
      'Est nisi incididunt aliquip  commodo aliqua tempor.';
  static const String addedToCart = 'Added to cart';

  // Packs
  static const String createOwnPack = 'Create Own Pack';
  static const String createMyPack = 'Create My Pack';
  static const String createBundlePack = 'Create Bundle Pack';
  static const String myPack = 'My Pack';
  static const String packDetails = 'Pack Details';
  static const String weight = 'Weight';
  static const String size = 'Size';
  static const String items = 'Item’s';
  static String quantityBadge(int qty) => 'x$qty';

  // Wishlist
  static const String myFavoriteList = 'My Favorite List';
  static const String emptyWishlist = 'Your wishlist is empty';
  static const String emptyWishlistSubtitle =
      'Tap the heart on a product to save it here.';

  // Cart
  static const String cartPage = 'Cart Page';
  static const String addCoupon = 'Add Coupon';
  static const String voucherHint = 'Entry Voucher Code';
  static const String totalItem = 'Total Item';
  static const String price = 'Price';
  static const String discount = 'Discount';
  static const String totalPrice = 'Total Price';
  static const String couponApplied = 'Coupon applied';
  static const String couponInvalid = 'This coupon code is not valid';
  static const String emptyCartTitle = 'Oppss!';
  static const String emptyCartSubtitle =
      'Sorry, you have no product in your cart.';
  static const String startBrowsing = 'Start Browsing';

  // Checkout
  static const String selectDeliveryAddress = 'Select delivery address';
  static const String addNew = 'Add New';
  static const String homeAddress = 'Home Address';
  static const String officeAddress = 'Office Address';
  static const String selectPaymentSystem = 'Select payment system';
  static const String masterCard = 'Master Card';
  static const String paypal = 'PayPal';
  static const String cashOnDelivery = 'Cash On Delivery';
  static const String cardName = 'Card Name';
  static const String cardNumber = 'Card Number';
  static const String expirationDate = 'Expiration Date';
  static const String cvv = 'CVV';
  static const String rememberCard = 'Remeber My Card Details';
  static const String payNow = 'Pay Now';

  // Order results
  static const String orderPlaced = 'Order Placed Successfully';
  static const String orderPlacedSubtitle =
      'Thanks for your order. Your order has placed successfully. Please continue your order.';
  static const String continueText = 'Continue';
  static const String trackOrder = 'Track Order';
  static const String orderFailed = 'Sorry, Order has Failed';
  static const String orderFailedSubtitle =
      'Sorry, somethings went wrong.\nPlease try again continue your order';
  static const String tryAgain = 'Try Again';
  static const String order = 'Order';
  static const String noOrdersYet = 'No Orders Yet';
  static const String noOrdersSubtitle =
      'Sorry you n’t haven’t placed\nany order yet.';
  static const String goBack = 'Go Back';

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

  // Fields
  static const String name = 'Name';
  static const String phoneNumber = 'Phone Number';
  static const String password = 'Password';
  static const String search = 'Search';

  // Validation
  static const String fieldRequired = 'This field is required';
  static const String invalidPhone = 'Enter a valid phone number';
  static const String passwordTooShort =
      'Password must be at least 6 characters';
  static const String passwordsDontMatch = 'Passwords do not match';
  static const String invalidOtp = 'Enter the 4 digit code';
  static const String invalidCardNumber = 'Enter a valid card number';
  static const String invalidExpiry = 'Use DD/MM/YYYY';
  static const String invalidCvv = 'Enter 3 or 4 digits';
}
