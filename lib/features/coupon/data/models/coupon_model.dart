import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

/// Ticket-style voucher (Offer And Promos list / Coupon Details).
class CouponModel {
  const CouponModel({
    required this.id,
    required this.percent,
    required this.title,
    required this.expiry,
    required this.color,
    this.pattern,
    this.terms = defaultTerms,
  });

  final String id;
  final int percent;
  final String title;
  final String expiry;
  final Color color;

  /// Faint decoration SVG drawn on the card.
  final String? pattern;
  final List<String> terms;

  double get rate => percent / 100;

  static const List<String> defaultTerms = [
    'Redeemable At All Sulphurfree Bura And Black Coffee',
    'Not Valid With Any Other Discount And Promotion',
    'Vaild For Sulphurfree, Coffee, And Tea Only',
    'No Cash Value',
  ];

  static const List<CouponModel> demo = [
    CouponModel(id: 'black_coffee', percent: 41, title: 'Black Coffee', expiry: '28/12/2020', color: AppColors.couponIndigo, pattern: AppAssets.couponBow),
    CouponModel(id: 'lifebuoy', percent: 23, title: 'Lifebuoy Handwash', expiry: '28/12/2020', color: AppColors.couponBlue, pattern: AppAssets.couponWaves),
    CouponModel(id: 'oreo', percent: 50, title: 'Oreo Biscut', expiry: '28/12/2020', color: AppColors.couponGreen, pattern: AppAssets.couponTriangles),
    CouponModel(id: 'tuna', percent: 18, title: 'Tuna Fish', expiry: '28/12/2020', color: AppColors.couponCyan, pattern: AppAssets.couponDots),
    CouponModel(id: 'vegetable', percent: 20, title: 'Vegetable', expiry: '28/12/2020', color: AppColors.couponIndigo, pattern: AppAssets.couponWaves),
  ];
}

/// Flat-amount promo card (Offer And Promos grid).
class PromoModel {
  const PromoModel({required this.title, required this.origin, required this.discount, required this.color});

  final String title;
  final String origin;
  final String discount;
  final Color color;

  static const List<PromoModel> demo = [
    PromoModel(title: 'Black Coffee', origin: 'Turkey', discount: '\$120', color: AppColors.promoPurple),
    PromoModel(title: 'Tomato', origin: 'Bangladeshi', discount: '\$12', color: AppColors.promoNavy),
    PromoModel(title: 'Sunflower Oil', origin: 'Turkey', discount: '10\$', color: AppColors.promoTeal),
    PromoModel(title: 'Papaya', origin: 'Bangladeshi', discount: '70\$', color: AppColors.promoBlue),
    PromoModel(title: 'Sunflower Oil', origin: 'Turkey', discount: '10\$', color: AppColors.promoCrimson),
    PromoModel(title: 'Papaya', origin: 'Bangladeshi', discount: '70\$', color: AppColors.promoOrange),
  ];
}
