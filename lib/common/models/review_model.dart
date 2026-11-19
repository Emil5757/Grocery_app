import 'dart:typed_data';

import 'package:flutter/painting.dart';

/// One product review. Written by Submit Review, listed by Review, kept in
/// `ReviewCubit`, so it lives in `common/`. Mock reviews: `ReviewData`.
class ReviewModel {
  const ReviewModel({
    required this.name,
    required this.avatar,
    required this.avatarBackground,
    required this.date,
    required this.rating,
    required this.text,
    this.likes = 24,
    this.photo,
    this.productId,
    this.isMine = false,
  });

  final String name;

  /// Portrait asset (used when [photo] is null).
  final String avatar;
  final Color avatarBackground;

  /// Already formatted: "12 Days ago", "Just now".
  final String date;
  final double rating;
  final String text;
  final int likes;

  /// The reviewer's own cropped photo, when they set one.
  final Uint8List? photo;

  /// Which product it is about; `null` = the store in general (Delivered).
  final String? productId;

  /// Written by the signed-in user in this session.
  final bool isMine;
}

/// The 4.5 / 320 reviews / per-star bars header.
class RatingSummary {
  const RatingSummary({required this.average, required this.total, required this.counts});

  final double average;

  /// One decimal for display: 4.956... -> "5.0", 4.5 -> "4.5".
  String get averageLabel => average.toStringAsFixed(1);

  /// Number of written reviews ("320 reviews"). Not the sum of [counts]:
  /// star-only ratings are counted in the bars but have no review text.
  final int total;

  /// Index 0 = 5 stars … index 4 = 1 star.
  final List<int> counts;

  /// This summary plus one more review of `stars` (1..5).
  RatingSummary plus(int stars) {
    final ratings = counts.fold<int>(0, (a, b) => a + b);
    final next = [...counts];
    next[5 - stars] += 1;
    return RatingSummary(
      average: (average * ratings + stars) / (ratings + 1),
      total: total + 1,
      counts: next,
    );
  }
}
