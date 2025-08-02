import 'package:thuongmaidientu/features/review/domain/entities/review.dart';
import 'package:thuongmaidientu/features/review/domain/repositories/review_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../datasources/review_remote_datasource.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDatasource remoteDataSource;

  ReviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<Review>> getListReview(String id) async {
    final userModel = await remoteDataSource.getListReview(id);
    return userModel;
  }

  @override
  Future<void> createReview(Review review, String id) async {
    await remoteDataSource.createReview(review, id);
  }
}
