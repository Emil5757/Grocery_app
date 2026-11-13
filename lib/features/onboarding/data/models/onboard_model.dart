import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_texts.dart';

/// An SVG placed on the 414-wide onboarding canvas at its design position.
class OnboardLayer {
  const OnboardLayer({
    required this.asset,
    required this.left,
    required this.top,
    required this.width,
  });

  final String asset;
  final double left;
  final double top;
  final double width;
}

/// One onboarding slide. Every illustration is positioned so its green
/// background circle (r = 160) sits at the same spot, so only the picture
/// and text change when swiping.
class OnboardModel {
  const OnboardModel({
    required this.layers,
    required this.title,
    required this.description,
  });

  final List<OnboardLayer> layers;
  final String title;
  final String description;

  /// Illustration canvas in design units.
  static const double canvasWidth = 414;
  static const double canvasHeight = 400;

  static const List<OnboardModel> pages = [
    OnboardModel(
      title: AppTexts.onboardCategoryTitle,
      description: AppTexts.onboardDescription,
      layers: [
        OnboardLayer(asset: AppAssets.onboardingCategory, left: 0, top: 22, width: 393),
      ],
    ),
    OnboardModel(
      title: AppTexts.onboardDiscountTitle,
      description: AppTexts.onboardDescription,
      layers: [
        OnboardLayer(asset: AppAssets.onboardingDiscount, left: 22, top: 7, width: 352),
        OnboardLayer(asset: AppAssets.onboardingSaleBadge, left: 262, top: 14, width: 135),
      ],
    ),
    OnboardModel(
      title: AppTexts.onboardDeliveryTitle,
      description: AppTexts.onboardDescription,
      layers: [
        OnboardLayer(asset: AppAssets.onboardingDelivery, left: 26, top: 40, width: 365),
      ],
    ),
  ];
}
