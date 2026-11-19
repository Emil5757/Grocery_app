import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../models/review_model.dart';

/// Mock reviews shown under every product (no backend yet). Reviews the user
/// writes are added on top by `ReviewCubit`.
abstract final class ReviewData {
  static const String _text =
      'Aliqua officia duis occaecat consectetur fugiat nostrud anim dolor commodo officia proident. '
      'Voluptate nisi reprehenderit.';

  static const List<ReviewModel> demo = [
    ReviewModel(
      name: 'Ronti Jordan',
      avatar: AppAssets.avatarRonti,
      avatarBackground: AppColors.avatarPink,
      date: '12 Days ago',
      rating: 5,
      text: _text,
    ),
    ReviewModel(
      name: 'Jenilliya Cartoos',
      avatar: AppAssets.avatarJenilliya,
      avatarBackground: AppColors.avatarPeach,
      date: '25 Dec, 2020',
      rating: 5,
      text: _text,
    ),
    ReviewModel(
      name: 'Anjelina Joli',
      avatar: AppAssets.avatarAnjelina,
      avatarBackground: AppColors.avatarLilac,
      date: '30 Dec, 2020',
      rating: 5,
      text: _text,
    ),
  ];

  static const RatingSummary summary = RatingSummary(average: 4.5, total: 320, counts: [200, 150, 90, 30, 20]);
}
