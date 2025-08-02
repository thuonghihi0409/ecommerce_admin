import 'package:thuongmaidientu/features/notification/domain/entities/notification_entity.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class NotificationRepository {
  Future<ListModel<NotificationEntity>> getListNotification(String id);
}
