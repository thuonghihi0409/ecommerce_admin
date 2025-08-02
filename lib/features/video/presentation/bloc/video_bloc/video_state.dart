part of 'video_bloc.dart';

class VideoState extends Equatable {
  final ListModel<VideoEntity> listVideo;

  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;

  const VideoState({
    required this.listVideo,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  factory VideoState.empty() {
    return const VideoState(
      listVideo: ListModel(),
      isLoading: false,
      isLoadingMore: false,
      isRefreshing: false,
    );
  }

  VideoState copyWith({
    bool? isGetDetail,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
    ListModel<VideoEntity>? listVideo,
  }) {
    return VideoState(
      listVideo: listVideo ?? this.listVideo,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
        listVideo,
        isLoading,
        isLoadingMore,
        isRefreshing,
      ];
}
