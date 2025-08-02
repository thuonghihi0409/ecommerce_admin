part of 'review_bloc.dart';

class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class GetListReview extends ReviewEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListReview(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class CreateReview extends ReviewEvent {
  final Review review;
  final String productOrderItemId;
  final Function? onSuccess;

  const CreateReview(
      {required this.review,
      required this.onSuccess,
      required this.productOrderItemId});
}
