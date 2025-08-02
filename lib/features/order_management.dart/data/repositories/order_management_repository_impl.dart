import 'package:thuongmaidientu/features/order_management.dart/data/datasources/order_management_remote_datasource.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/entities/seller_order_item.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/repositories/order_management_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class OrderManagementRepositoryImpl implements OrderManagementRepository {
  final OrderManagementRemoteDatasource remoteDataSource;

  OrderManagementRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<SellerOrderItem>> getListOrder(
      String storeId, String status) async {
    final userModel = await remoteDataSource.getListOrder(storeId, status);
    return userModel;
  }

  @override
  Future<void> updateOrder(String id, SellerOrderItem order) async {
    await remoteDataSource.updateOrder(id, order);
  }

  @override
  Future<int> getCount(String userId) async {
    final count = await remoteDataSource.getCount(userId);
    return count;
  }
}
