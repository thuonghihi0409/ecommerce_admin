import 'package:thuongmaidientu/features/review/domain/entities/review.dart';

import '../repositories/review_repository.dart';

class CreateReviewUsecase {
  final ReviewRepository repository;

  CreateReviewUsecase(this.repository);

  Future<void> call(Review review, String id) {
    return repository.createReview(review, id);
  }
}
