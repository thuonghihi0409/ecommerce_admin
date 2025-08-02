part of 'order_management_bloc.dart';

class OrderManagementEvent extends Equatable {
  const OrderManagementEvent();

  @override
  List<Object> get props => [];
}

class SellerGetListOrder extends OrderManagementEvent {
  final String? id;
  final Function(OrderManagementState)? onSuccess;
  final OrderStatus orderStatus;
  final bool isLoadingMore, isRefreshing;
  const SellerGetListOrder(
      {this.id,
      this.orderStatus = OrderStatus.pending,
      this.isLoadingMore = false,
      this.isRefreshing = false,
      this.onSuccess});
}

class UpdateOrder extends OrderManagementEvent {
  final String id;
  final SellerOrderItem order;
  final OrderStatus newStatus;

  const UpdateOrder(
      {required this.id, required this.order, required this.newStatus});
}

class GetCountOrder extends OrderManagementEvent {
  final String? userId;

  const GetCountOrder({
    required this.userId,
  });
}
