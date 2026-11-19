import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

/// What tapping a notification opens.
enum NotificationTarget { offers, promos, orders, tracking, delivered }

class NotificationModel {
  const NotificationModel({
    required this.title,
    required this.body,
    required this.time,
    required this.color,
    required this.target,
    this.svg,
    this.icon,
  });

  final String title;
  final String body;
  final String time;
  final Color color;
  final NotificationTarget target;

  /// White SVG glyph from the kit, or a Material icon when the kit has none.
  final String? svg;
  final IconData? icon;

  static const String _deal = 'Hot Deal Buy one get free one Offer Hery...';

  static const List<NotificationModel> demo = [
    NotificationModel(title: 'Gifts Offer', body: _deal, time: 'Now', color: AppColors.notifyBlue, icon: Icons.card_giftcard, target: NotificationTarget.offers),
    NotificationModel(title: 'Coupon Offer', body: _deal, time: '10 Minute Ago', color: AppColors.notifyPink, svg: AppAssets.icNotificationCoupon, target: NotificationTarget.offers),
    NotificationModel(title: 'Congratulations', body: 'You get your order', time: '15 Minute Ago', color: AppColors.notifyGreen, svg: AppAssets.icNotificationTruck, target: NotificationTarget.delivered),
    NotificationModel(title: 'Your Order Cancelled', body: _deal, time: '2 Hours Ago', color: AppColors.notifyRed, icon: Icons.remove_shopping_cart_outlined, target: NotificationTarget.orders),
    NotificationModel(title: 'Great Winter Discount', body: _deal, time: '10 Minute Ago', color: AppColors.notifyPink, icon: Icons.discount_outlined, target: NotificationTarget.promos),
    NotificationModel(title: '20% Off in Vegetable', body: _deal, time: '10 Minute Ago', color: AppColors.notifyBlue, icon: Icons.percent, target: NotificationTarget.promos),
  ];
}
