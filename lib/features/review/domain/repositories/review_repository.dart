import 'package:thuongmaidientu/features/review/domain/entities/review.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class ReviewRepository {
  Future<ListModel<Review>> getListReview(String id);
  Future<void> createReview(Review review, String id);
}
