import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/review_data.dart';
import '../../models/review_model.dart';

/// Reviews the user has submitted, newest first. Submit Review adds to it
/// and Review shows them, from Product Details or from Delivered, so the
/// Cubit is app-wide (provided above `MaterialApp`).
class ReviewCubit extends Cubit<List<ReviewModel>> {
  ReviewCubit() : super(const []);

  void add(ReviewModel review) => emit(List.unmodifiable([review, ...state]));

  /// The user's reviews of a product (`null` = store reviews), then the mock
  /// ones.
  List<ReviewModel> reviewsFor(String? productId) => [
        ...state.where((r) => r.productId == productId),
        ...ReviewData.demo,
      ];

  /// The mock summary plus every review the user wrote for that product.
  RatingSummary summaryFor(String? productId) => state
      .where((r) => r.productId == productId)
      .fold(ReviewData.summary, (s, r) => s.plus(r.rating.round()));
}
