import 'package:thuongmaidientu/features/order_management.dart/domain/entities/seller_order_item.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class OrderManagementRepository {
  Future<ListModel<SellerOrderItem>> getListOrder(
      String storeId, String status);

  Future<void> updateOrder(String id, SellerOrderItem order);
  Future<int> getCount(String userId);
}
