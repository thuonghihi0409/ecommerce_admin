import 'package:thuongmaidientu/features/notification/domain/entities/notification_entity.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../repositories/notification_repository.dart';

class GetListNotificationUseCase {
  final NotificationRepository repository;

  GetListNotificationUseCase(this.repository);

  Future<ListModel<NotificationEntity>> call(String id) {
    return repository.getListNotification(id);
  }
}
