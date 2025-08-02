import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/entities/seller_order_item.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/usecases/seller_get_list_order_usecase.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/usecases/update_order_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'order_management_event.dart';
part 'order_management_state.dart';

class OrderManagementBloc
    extends Bloc<OrderManagementEvent, OrderManagementState> {
  final SellerGetListOrderUsecase getListOrderUseCase;

  final SellerUpdateOrderUsecase updateOrderUsecase;

  OrderManagementBloc(
    this.getListOrderUseCase,
    this.updateOrderUsecase,
  ) : super(OrderManagementState.empty()) {
    on<SellerGetListOrder>(_getListOrder);

    on<UpdateOrder>(_updateOrder);
  }

  void _getListOrder(
      SellerGetListOrder event, Emitter<OrderManagementState> emit) async {
    final userId = event.id ?? "";
    final status = event.orderStatus;
    log(userId);

    try {
      // Bắt đầu loading cho đúng danh sách theo status
      emit(_setLoadingState(status, isLoading: true));

      final result =
          await getListOrderUseCase.call(userId, orderStatusToString(status));

      // Cập nhật danh sách sau khi lấy xong
      emit(_setListOrderByStatus(status, result));
    } catch (e) {
      emit(_setLoadingState(status, isLoading: false));

      final message = ParseError.fromJson(e).message;
      Helper.showToastBottom(message: message);
      log(message);
    }
  }

  OrderManagementState _setLoadingState(OrderStatus status,
      {required bool isLoading}) {
    switch (status) {
      case OrderStatus.pending:
        return state.copyWith(
          listOrderPending:
              state.listOrderPending.copyWith(isLoading: isLoading),
        );
      case OrderStatus.awaiting:
        return state.copyWith(
          listOrderWaiting:
              state.listOrderWaiting.copyWith(isLoading: isLoading),
        );
      case OrderStatus.delivering:
        return state.copyWith(
          listOrderDelivering:
              state.listOrderDelivering.copyWith(isLoading: isLoading),
        );
      case OrderStatus.delivered:
        return state.copyWith(
          listOrderDelivered:
              state.listOrderDelivered.copyWith(isLoading: isLoading),
        );
      case OrderStatus.cancelled:
        return state.copyWith(
          listOrderCancelled:
              state.listOrderCancelled.copyWith(isLoading: isLoading),
        );
    }
  }

  OrderManagementState _setListOrderByStatus(
      OrderStatus status, ListModel<SellerOrderItem>? data) {
    switch (status) {
      case OrderStatus.pending:
        return state.copyWith(listOrderPending: data);
      case OrderStatus.awaiting:
        return state.copyWith(listOrderWaiting: data);
      case OrderStatus.delivering:
        return state.copyWith(listOrderDelivering: data);
      case OrderStatus.delivered:
        return state.copyWith(listOrderDelivered: data);
      case OrderStatus.cancelled:
        return state.copyWith(listOrderCancelled: data);
    }
  }

  void _updateOrder(
      UpdateOrder event, Emitter<OrderManagementState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await updateOrderUsecase.call(
          event.id, event.order.copyWith(orderStatus: event.newStatus));

      add(SellerGetListOrder(orderStatus: event.order.status, id: event.id));
      add(SellerGetListOrder(orderStatus: event.newStatus, id: event.id));
      emit(state.copyWith(
        isLoading: false,
      ));
      // Helper.showToastBottom(
      //     message: "key_update_cart_success".tr(), type: ToastType.success);
    } catch (e) {
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      log(ParseError.fromJson(e).message);
    }
  }
}
