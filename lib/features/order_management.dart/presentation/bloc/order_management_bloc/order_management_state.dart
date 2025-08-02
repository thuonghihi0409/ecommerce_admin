part of 'order_management_bloc.dart';

class OrderManagementState extends Equatable {
  final ListModel<SellerOrderItem> listOrderPending; // Chờ duyệt
  final ListModel<SellerOrderItem> listOrderWaiting; // Chuẩn bị hàng
  final ListModel<SellerOrderItem> listOrderDelivering; // Đang giao
  final ListModel<SellerOrderItem> listOrderDelivered; // Đã giao
  final ListModel<SellerOrderItem> listOrderCancelled; // Đã hủy
  final ListModel<SellerOrderItem> listOrderReviewed; // Đánh giá

  final int count;
  final bool isGetDetail;
  final bool isLoading; // loading when create order
  final bool isLoadingMore;
  final bool isRefreshing;

  const OrderManagementState(
      {required this.listOrderPending,
      required this.listOrderWaiting,
      required this.listOrderDelivering,
      required this.listOrderDelivered,
      required this.listOrderCancelled,
      required this.listOrderReviewed,
      this.isGetDetail = false,
      this.isLoading = false,
      this.isLoadingMore = false,
      this.isRefreshing = false,
      this.count = 0});

  factory OrderManagementState.empty() {
    return const OrderManagementState(
        listOrderPending: ListModel(),
        listOrderWaiting: ListModel(),
        listOrderDelivering: ListModel(),
        listOrderDelivered: ListModel(),
        listOrderCancelled: ListModel(),
        listOrderReviewed: ListModel(),
        isGetDetail: false,
        isLoading: false,
        isLoadingMore: false,
        isRefreshing: false,
        count: 0);
  }

  OrderManagementState copyWith(
      {ListModel<SellerOrderItem>? listOrderPending,
      ListModel<SellerOrderItem>? listOrderWaiting,
      ListModel<SellerOrderItem>? listOrderDelivering,
      ListModel<SellerOrderItem>? listOrderDelivered,
      ListModel<SellerOrderItem>? listOrderCancelled,
      ListModel<SellerOrderItem>? listOrderReviewed,
      bool? isGetDetail,
      bool? isLoading,
      bool? isLoadingMore,
      bool? isRefreshing,
      int? count}) {
    return OrderManagementState(
        listOrderPending: listOrderPending ?? this.listOrderPending,
        listOrderWaiting: listOrderWaiting ?? this.listOrderWaiting,
        listOrderDelivering: listOrderDelivering ?? this.listOrderDelivering,
        listOrderDelivered: listOrderDelivered ?? this.listOrderDelivered,
        listOrderCancelled: listOrderCancelled ?? this.listOrderCancelled,
        listOrderReviewed: listOrderReviewed ?? this.listOrderReviewed,
        isGetDetail: isGetDetail ?? this.isGetDetail,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        count: count ?? this.count);
  }

  @override
  List<Object?> get props => [
        listOrderPending,
        listOrderWaiting,
        listOrderDelivering,
        listOrderDelivered,
        listOrderCancelled,
        listOrderReviewed,
        isGetDetail,
        isLoading,
        isLoadingMore,
        isRefreshing,
        count
      ];
}
