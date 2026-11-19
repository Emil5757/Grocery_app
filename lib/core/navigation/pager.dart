import 'package:flutter/material.dart';

import '../../common/models/category_model.dart';
import '../../features/address/pages/delivery_address_page.dart';
import '../../features/address/pages/new_address_page.dart';
import '../../features/coupon/data/models/coupon_model.dart';
import '../../features/coupon/pages/coupon_details_page.dart';
import '../../features/coupon/pages/offers_page.dart';
import '../../features/coupon/pages/promos_page.dart';
import '../../features/error/pages/error_page.dart';
import '../../features/orders/pages/delivered_page.dart';
import '../../features/review/pages/review_page.dart';
import '../../features/review/pages/submit_review_page.dart';
import '../../features/notification/pages/notification_page.dart';
import '../../features/notification/pages/notification_settings_page.dart';
import '../../features/orders/data/models/order_model.dart';
import '../../features/orders/pages/my_orders_page.dart';
import '../../features/orders/pages/order_details_page.dart';
import '../../features/orders/pages/order_tracking_page.dart';
import '../../features/profile/pages/change_password_page.dart';
import '../../features/profile/pages/change_phone_page.dart';
import '../../features/profile/pages/edit_profile_page.dart';
import '../../features/profile/pages/language_page.dart';
import '../../features/profile/pages/profile_page.dart';
import '../../features/profile/pages/setting_page.dart';
import '../../common/models/pack_model.dart';
import '../../common/models/product_model.dart';
import '../../features/auth/pages/forget_password_page.dart';
import '../../features/auth/pages/login_options_page.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/new_password_page.dart';
import '../../features/auth/pages/number_verification_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/auth/pages/welcome_page.dart';
import '../../features/cart/pages/cart_page.dart';
import '../../features/category/pages/category_page.dart';
import '../../features/category/pages/category_products_page.dart';
import '../../features/checkout/pages/checkout_page.dart';
import '../../features/checkout/pages/order_failed_page.dart';
import '../../features/checkout/pages/order_success_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/main/pages/main_page.dart';
import '../../features/onboarding/pages/onboarding_page.dart';
import '../../features/orders/pages/no_orders_page.dart';
import '../../features/pack/pages/bundle_details_page.dart';
import '../../features/pack/pages/create_my_pack_page.dart';
import '../../features/pack/pages/pack_details_page.dart';
import '../../features/pack/pages/popular_pack_page.dart';
import '../../features/product/pages/new_items_page.dart';
import '../../features/product/pages/product_details_page.dart';
import '../../features/search/pages/search_page.dart';
import '../../features/search/pages/search_result_page.dart';
import '../../features/splash/pages/splash_page.dart';
import '../../features/wishlist/pages/favorite_page.dart';

/// Registry of every destination. Add each new page here as a
/// `static const` (or a method when it needs arguments / a `BlocProvider`).
///
/// Flow: splash -replace-> onboarding -replace-> welcome
///       welcome -to-> loginOptions -to-> login
///       welcome -to-> signUp <-replace-> login
///       signUp -to-> numberVerification (Verify -> "Verified!!" dialog)
///       login -to-> forgetPassword -to-> newPassword -removeAll-> login
///       login / "Verified!!" dialog -removeAll-> main
///       main tabs: home | category | favorites | profile
///       profile -to-> myOrders -to-> orderDetails, offers -to-> couponDetails,
///                 deliveryAddress -to-> newAddress, editProfile, notifications,
///                 setting -to-> language / changePassword / changePhone
///       orderSuccess / setting(Location) / notifications -to-> orderTracking
///       productDetails / packDetails -to-> review -to-> submitReview
///       notifications -to-> delivered -replace-> submitReview | -removeAll-> main
///       unknown routes -> error
///       home -to-> search -to-> searchResult -to-> productDetails
///       home -to-> popularPack -to-> createMyPack -to-> bundleDetails -replace-> cart
///       home / popularPack -to-> packDetails -to-> cart
///       cart -to-> checkout -removeAll-> orderSuccess (or -to-> orderFailed)
abstract final class Pager {
  // Auth
  static const Widget splash = SplashPage();
  static const Widget onboarding = OnboardingPage();
  static const Widget welcome = WelcomePage();
  static const Widget loginOptions = LoginOptionsPage();
  static const Widget login = LoginPage();
  static const Widget signUp = SignUpPage();
  static const Widget numberVerification = NumberVerificationPage();
  static const Widget forgetPassword = ForgetPasswordPage();
  static const Widget newPassword = NewPasswordPage();

  // Shell and its tabs
  static const Widget main = MainPage();
  static const Widget home = HomePage();
  static const Widget category = CategoryPage();
  static Widget favorites({VoidCallback? onBack}) =>
      FavoritePage(onBack: onBack);

  // Browse
  static const Widget search = SearchPage();
  static Widget searchResult(String query) => SearchResultPage(query: query);
  static Widget categoryProducts(CategoryModel category) =>
      CategoryProductsPage(category: category);
  static Widget productDetails(ProductModel product) =>
      ProductDetailsPage(product: product);
  static const Widget newItems = NewItemsPage();

  // Packs
  static const Widget popularPack = PopularPackPage();
  static Widget packDetails(PackModel pack) => PackDetailsPage(pack: pack);
  static const Widget createMyPack = CreateMyPackPage();
  static Widget bundleDetails(Map<ProductModel, int> selection) =>
      BundleDetailsPage(selection: selection);

  // Cart & checkout
  static const Widget cart = CartPage();
  static const Widget checkout = CheckoutPage();
  static const Widget orderSuccess = OrderSuccessPage();
  static const Widget orderFailed = OrderFailedPage();
  static const Widget noOrders = NoOrdersPage();

  // Profile & account
  static Widget profile({VoidCallback? onBack}) => ProfilePage(onBack: onBack);
  static const Widget editProfile = EditProfilePage();
  static const Widget setting = SettingPage();
  static const Widget changePassword = ChangePasswordPage();
  static const Widget changePhone = ChangePhonePage();
  static const Widget language = LanguagePage();

  // Orders
  static const Widget myOrders = MyOrdersPage();
  static Widget orderDetails(OrderModel order) => OrderDetailsPage(order: order);
  static const Widget orderTracking = OrderTrackingPage();

  // Addresses
  static const Widget deliveryAddress = DeliveryAddressPage();
  static Widget newAddress({int? editIndex}) => NewAddressPage(editIndex: editIndex);

  // Notifications
  static const Widget notifications = NotificationPage();
  static const Widget notificationSettings = NotificationSettingsPage();

  // Coupons
  static const Widget offers = OffersPage();
  static const Widget promos = PromosPage();
  static Widget couponDetails(CouponModel coupon) => CouponDetailsPage(coupon: coupon);

  // Reviews
  static const Widget review = ReviewPage();
  static const Widget submitReview = SubmitReviewPage();

  // Results
  static const Widget delivered = DeliveredPage();
  static Widget error({String? title, VoidCallback? onRetry}) =>
      title == null ? ErrorPage(onRetry: onRetry) : ErrorPage(title: title, onRetry: onRetry);
}