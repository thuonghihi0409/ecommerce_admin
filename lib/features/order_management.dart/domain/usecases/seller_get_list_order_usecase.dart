import 'package:thuongmaidientu/features/order_management.dart/domain/entities/seller_order_item.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/repositories/order_management_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class SellerGetListOrderUsecase {
  final OrderManagementRepository repository;

  SellerGetListOrderUsecase(this.repository);

  Future<ListModel<SellerOrderItem>?> call(
      String storeId, String status) async {
    return repository.getListOrder(storeId, status);
  }
}
