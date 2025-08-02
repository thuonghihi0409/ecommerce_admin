part of 'notification_bloc.dart';

class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetListNotification extends NotificationEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListNotification(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class ReadAnNotification extends NotificationEvent {
  final String? id;

  const ReadAnNotification({
    this.id,
  });
}

class ReadAllNotification extends NotificationEvent {
  final String userId;
  const ReadAllNotification({required this.userId});
}
