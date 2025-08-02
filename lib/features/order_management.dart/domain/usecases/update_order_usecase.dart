import 'package:thuongmaidientu/features/order_management.dart/domain/entities/seller_order_item.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/repositories/order_management_repository.dart';

class SellerUpdateOrderUsecase {
  final OrderManagementRepository repository;

  SellerUpdateOrderUsecase(this.repository);

  Future<void> call(String userId, SellerOrderItem order) {
    return repository.updateOrder(userId, order);
  }
}
