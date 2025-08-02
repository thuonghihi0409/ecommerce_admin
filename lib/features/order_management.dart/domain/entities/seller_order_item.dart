import 'package:thuongmaidientu/features/order_management.dart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/profile_entity.dart';

enum OrderStatus {
  pending, // Chờ duyệt
  awaiting, // Chuẩn bị hàng
  delivering, // Đang giao
  delivered, // Đã giao
  cancelled, // Đã hủy
}

OrderStatus orderStatusFromString(String status) {
  switch (status) {
    case 'pending':
      return OrderStatus.pending;
    case 'awaiting':
      return OrderStatus.awaiting;
    case 'delivering':
      return OrderStatus.delivering;
    case 'delivered':
      return OrderStatus.delivered;
    case 'cancelled':
      return OrderStatus.cancelled;

    default:
      throw Exception('Unknown order status: $status');
  }
}

String orderStatusToString(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return 'pending';
    case OrderStatus.awaiting:
      return 'awaiting';
    case OrderStatus.delivering:
      return 'delivering';
    case OrderStatus.delivered:
      return 'delivered';
    case OrderStatus.cancelled:
      return 'cancelled';
  }
}

String orderStatusToText(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return 'Chờ duyệt';
    case OrderStatus.awaiting:
      return 'Chuẩn bị hàng';
    case OrderStatus.delivering:
      return 'Đang giao';
    case OrderStatus.delivered:
      return 'Đã giao';
    case OrderStatus.cancelled:
      return 'Đã hủy';
  }
}

class SellerOrderItem {
  final String id;
  final ProfileEntity user;
  final int subtotal;
  final int total;
  final OrderStatus status;
  final List<ProductItem> productItem;
  final AddressEntity? address;

  SellerOrderItem(
      {required this.user,
      required this.productItem,
      required this.id,
      required this.status,
      required this.address,
      required this.subtotal,
      required this.total});
  SellerOrderItem copyWith({required OrderStatus? orderStatus}) {
    return SellerOrderItem(
        user: user,
        productItem: productItem,
        id: id,
        status: orderStatus ?? status,
        address: address,
        subtotal: subtotal,
        total: total);
  }
}
