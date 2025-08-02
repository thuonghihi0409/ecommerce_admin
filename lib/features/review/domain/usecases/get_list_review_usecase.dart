import 'package:thuongmaidientu/features/review/domain/entities/review.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../repositories/review_repository.dart';

class GetListReviewUseCase {
  final ReviewRepository repository;

  GetListReviewUseCase(this.repository);

  Future<ListModel<Review>> call(String id) {
    return repository.getListReview(id);
  }
}
