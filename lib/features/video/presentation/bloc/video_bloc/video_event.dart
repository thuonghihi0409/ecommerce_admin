part of 'video_bloc.dart';

class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class GetListVideo extends VideoEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListVideo(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class GetListCategory extends VideoEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListCategory(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class GetReviewDetail extends VideoEvent {
  final String ReviewId;
  const GetReviewDetail({required this.ReviewId});
}
