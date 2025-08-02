part of 'review_bloc.dart';

class ReviewState extends Equatable {
  final ListModel<Review> listReview;

  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;

  const ReviewState({
    required this.listReview,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  factory ReviewState.empty() {
    return const ReviewState(
      listReview: ListModel(),
      isLoading: false,
      isLoadingMore: false,
      isRefreshing: false,
    );
  }

  ReviewState copyWith({
    bool? isGetDetail,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
    ListModel<Review>? listReview,
  }) {
    return ReviewState(
      listReview: listReview ?? this.listReview,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
        listReview,
        isLoading,
        isLoadingMore,
        isRefreshing,
      ];
}
