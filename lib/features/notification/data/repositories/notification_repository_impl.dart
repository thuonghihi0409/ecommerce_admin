import 'package:thuongmaidientu/features/notification/domain/entities/notification_entity.dart';
import 'package:thuongmaidientu/features/notification/domain/repositories/notification_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../datasources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDatasource remoteDataSource;

  NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<NotificationEntity>> getListNotification(String id) async {
    final userModel = await remoteDataSource.getListNotification(id);
    return userModel;
  }
}
