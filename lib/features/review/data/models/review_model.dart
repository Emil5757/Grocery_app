import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

class ReviewModel {
  const ReviewModel({
    required this.name,
    required this.avatar,
    required this.avatarBackground,
    required this.date,
    required this.rating,
    required this.text,
    this.likes = 24,
  });

  final String name;
  final String avatar;
  final Color avatarBackground;
  final String date;
  final double rating;
  final String text;
  final int likes;

  static const String _text =
      'Aliqua officia duis occaecat consectetur fugiat nostrud anim dolor commodo officia proident. '
      'Voluptate nisi reprehenderit.';

  static const List<ReviewModel> demo = [
    ReviewModel(name: 'Ronti Jordan', avatar: AppAssets.avatarRonti, avatarBackground: AppColors.avatarPink, date: '12 Days ago', rating: 5, text: _text),
    ReviewModel(name: 'Jenilliya Cartoos', avatar: AppAssets.avatarJenilliya, avatarBackground: AppColors.avatarPeach, date: '25 Dec, 2020', rating: 5, text: _text),
    ReviewModel(name: 'Anjelina Joli', avatar: AppAssets.avatarAnjelina, avatarBackground: AppColors.avatarLilac, date: '30 Dec, 2020', rating: 5, text: _text),
  ];
}

/// The 4.5 / 320 reviews / per-star bars header.
class RatingSummary {
  const RatingSummary({required this.average, required this.counts});

  final double average;

  /// Index 0 = 5 stars … index 4 = 1 star.
  final List<int> counts;

  int get total => counts.fold(0, (a, b) => a + b);

  static const demo = RatingSummary(average: 4.5, counts: [200, 150, 90, 30, 20]);
}
