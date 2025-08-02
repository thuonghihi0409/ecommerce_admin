import 'package:thuongmaidientu/features/order_management.dart/data/models/order_item_model.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/entities/seller_order_item.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class OrderManagementRemoteDatasource {
  Future<ListModel<SellerOrderItemModel>> getListOrder(
      String storeId, String status);
  Future<int> getCount(String userId);

  Future<void> updateOrder(String userId, SellerOrderItem order);
}

class OrderManagementRemoteDataSourceImpl
    implements OrderManagementRemoteDatasource {
  OrderManagementRemoteDataSourceImpl();

  @override
  Future<ListModel<SellerOrderItemModel>> getListOrder(
      String storeId, String status) async {
    final data = await supabase.from("Orders").select('''
      *,
      user: Users(*),
      product_orders: ProductOrders(
      id,
      product: Products(*,
        images : Images(*),
        variants : Variants(*),
        store: Stores(*)),
      number,
      variant: Variants(*)
      
      ),address: Address(*)
      ''').eq('store_id', storeId).eq('status', status);

    final result = ListModel(
        results:
            data.map((item) => SellerOrderItemModel.fromJson(item)).toList());

    return result;
  }

  @override
  Future<void> updateOrder(String userId, SellerOrderItem order) async {
    if (order.status == OrderStatus.delivering) {
      await Future.wait(order.productItem.map((item) async {
        await supabase.from('Variants').update({
          'stock': (item.variant?.stock ?? 0) - item.number,
          'total_sold': (item.variant?.totalSold ?? 0) + item.number
        }).eq('id', item.variant?.id ?? "");
      }));
    }
    await supabase.from('Orders').update(
        {'status': orderStatusToString(order.status)}).eq('id', order.id);
  }

  @override
  Future<int> getCount(String userId) async {
    final data = await supabase
        .from('Orders')
        .select('status')
        .eq('user_id', userId)
        .filter('status', 'in', '("pending","awaiting","delivering")');
    return data.length;
  }
}
