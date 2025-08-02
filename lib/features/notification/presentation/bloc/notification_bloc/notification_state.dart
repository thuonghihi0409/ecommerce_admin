part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final ListModel<NotificationEntity> listNotification;

  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;

  const NotificationState({
    required this.listNotification,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  factory NotificationState.empty() {
    return const NotificationState(
      listNotification: ListModel(),
      isLoading: false,
      isLoadingMore: false,
      isRefreshing: false,
    );
  }

  NotificationState copyWith({
    bool? isGetDetail,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
    ListModel<NotificationEntity>? listNotification,
  }) {
    return NotificationState(
      listNotification: listNotification ?? this.listNotification,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
        listNotification,
        isLoading,
        isLoadingMore,
        isRefreshing,
      ];
}
