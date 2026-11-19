import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../../common/models/product_model.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';

/// Where an order is. `step` is how many of the 4 dots are filled.
enum OrderStatus {
  confirmed(AppTexts.confirmed, AppColors.confirmed, 1),
  processing(AppTexts.processing, AppColors.processing, 2),
  shipped(AppTexts.shipped, AppColors.shipped, 3),
  delivered(AppTexts.delivery, AppColors.delivered, 4),
  cancelled(AppTexts.cancelled, AppColors.error, 4);

  const OrderStatus(this.label, this.color, this.step);

  final String label;
  final Color color;
  final int step;

  bool get isRunning => this != delivered && this != cancelled;
}

class OrderLine {
  const OrderLine({
    required this.product,
    required this.name,
    required this.weight,
    required this.quantity,
    required this.total,
  });

  final ProductModel product;
  final String name;
  final String weight;
  final int quantity;

  /// Line total as charged (packs and offers differ from unit price × qty).
  final num total;
}

class OrderModel {
  const OrderModel({required this.id, required this.date, required this.status, this.lines = demoLines});

  final String id;
  final String date;
  final OrderStatus status;
  final List<OrderLine> lines;

  num get total => lines.fold<num>(0, (s, l) => s + l.total);

  static const List<OrderLine> demoLines = [
    OrderLine(product: ProductModel.papaya, name: 'Fresh Papaya Form The Farmer', weight: '3KG', quantity: 3, total: 30),
    OrderLine(product: ProductModel.tunaFish, name: 'Fresh Tuna Fish Form The Sea', weight: '1 KG', quantity: 5, total: 50),
    OrderLine(product: ProductModel.meat, name: 'Fresh Meat Form The Farmer', weight: '1 KG', quantity: 5, total: 50),
  ];

  static const List<OrderModel> all = [
    OrderModel(id: '2324252627', date: '25 Nov', status: OrderStatus.confirmed),
    OrderModel(id: '2324252628', date: '25 Nov', status: OrderStatus.processing),
    OrderModel(id: '2324252629', date: '24 Nov', status: OrderStatus.shipped),
    OrderModel(id: '2324252630', date: '22 Nov', status: OrderStatus.delivered),
    OrderModel(id: '2324252631', date: '21 Nov', status: OrderStatus.shipped),
    OrderModel(id: '2324252632', date: '20 Nov', status: OrderStatus.cancelled),
    OrderModel(id: '2324252633', date: '18 Nov', status: OrderStatus.confirmed),
    OrderModel(id: '2324252634', date: '15 Nov', status: OrderStatus.delivered),
  ];
}

/// One row of the My Order Details timeline.
class OrderStep {
  const OrderStep({
    required this.icon,
    required this.title,
    required this.date,
    required this.time,
    this.background,
  });

  final String icon;
  final String title;
  final String date;
  final String time;

  /// Square behind a glyph-only SVG (the kit's processing icon has none).
  final Color? background;

  static const List<OrderStep> demo = [
    OrderStep(icon: AppAssets.icOrderConfirmed, title: AppTexts.orderConfirmed, date: '12.12.2020', time: '01:00 PM'),
    OrderStep(icon: AppAssets.icOrderProcessing, title: AppTexts.orderProcessing, date: '13.12.2020', time: '03:00 PM', background: AppColors.processingBadge),
    OrderStep(icon: AppAssets.icOrderShipped, title: AppTexts.orderShipped, date: '15.12.2020', time: '05:00 PM'),
    OrderStep(icon: AppAssets.icOrderDelivered, title: AppTexts.delivery, date: '18.12.2020', time: '07:00 PM'),
  ];
}

/// Demo delivery for Order Tracking, drawn on OpenStreetMap. The route is
/// a real street path in Chhatak, taken once from the public OSRM router
/// (router.project-osrm.org) and stored here, so the app makes no routing
/// calls at runtime.
abstract final class TrackingModel {
  /// Shop near Chhatak Bazar.
  static const LatLng store = LatLng(25.028062, 91.658397);

  /// Where the rider is now.
  static const LatLng rider = LatLng(25.025824, 91.661643);

  /// Store -> rider (travelled, solid line).
  static const List<LatLng> travelled = [
    LatLng(25.028062, 91.658397),
    LatLng(25.028154, 91.658437),
    LatLng(25.028669, 91.658608),
    LatLng(25.029377, 91.65886),
    LatLng(25.029481, 91.658866),
    LatLng(25.029566, 91.6587),
    LatLng(25.029605, 91.658643),
    LatLng(25.029644, 91.658646),
    LatLng(25.029812, 91.658697),
    LatLng(25.030213, 91.658831),
    LatLng(25.030745, 91.659029),
    LatLng(25.030668, 91.659356),
    LatLng(25.030254, 91.661022),
    LatLng(25.029957, 91.662476),
    LatLng(25.029902, 91.662727),
    LatLng(25.029211, 91.662553),
    LatLng(25.029012, 91.662499),
    LatLng(25.025824, 91.661643),
  ];

  /// Rider -> home (still to go, dashed). The home point itself comes from
  /// the selected delivery address.
  static const List<LatLng> remainingVia = [LatLng(25.025296, 91.661501), LatLng(25.0247, 91.661324), LatLng(25.023858, 91.6611), LatLng(25.023461, 91.660998)];

  static const String deliveryTime = '30 Min';
  static const String shipperName = 'Jondy Carlos';
  static const String shipperPhone = '+8801710071000';
}
