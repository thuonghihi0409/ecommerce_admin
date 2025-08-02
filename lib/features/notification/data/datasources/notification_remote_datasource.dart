import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../models/notification_model.dart';

abstract class NotificationRemoteDatasource {
  Future<ListModel<NotificationModel>> getListNotification(String id);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDatasource {
  NotificationRemoteDataSourceImpl();

  @override
  Future<ListModel<NotificationModel>> getListNotification(String id) async {
    final data = await supabase.from("Notifications").select('''
    *,
    image_urls: Images(url),
    user: Users(*),
    variant: Variants(*)
    ''').eq("product_id", id);

    final result = ListModel(
        results: data
            .map((product) => NotificationModel.fromJson(product))
            .toList());

    return result;
  }
}
