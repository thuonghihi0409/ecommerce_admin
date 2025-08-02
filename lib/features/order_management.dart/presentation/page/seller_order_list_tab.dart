import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/entities/seller_order_item.dart';
import 'package:thuongmaidientu/features/order_management.dart/presentation/bloc/order_management_bloc/order_management_bloc.dart';
import 'package:thuongmaidientu/features/order_management.dart/presentation/widget/seller_order_item_widget.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/widgets/list_empty_widget.dart';

class SellerOrderListTab extends StatefulWidget {
  final OrderStatus status;

  const SellerOrderListTab({super.key, required this.status});

  @override
  State<SellerOrderListTab> createState() => _SellerOrderListTabState();
}

class _SellerOrderListTabState extends State<SellerOrderListTab> {
  late OrderManagementBloc _bloc;
  late String _storeId;
  ListModel _data = const ListModel();

  @override
  void initState() {
    super.initState();
    _storeId = context.read<ProfileBloc>().state.store?.id ?? "";
    _bloc = BlocProvider.of<OrderManagementBloc>(context);
    _bloc.add(SellerGetListOrder(orderStatus: widget.status, id: _storeId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderManagementBloc, OrderManagementState>(
        builder: (context, state) {
      switch (widget.status) {
        case OrderStatus.pending:
          _data = state.listOrderPending;
          break;
        case OrderStatus.delivered:
          _data = state.listOrderDelivered;
          break;
        case OrderStatus.cancelled:
          _data = state.listOrderCancelled;
          break;
        case OrderStatus.awaiting:
          _data = state.listOrderWaiting;
          break;
        case OrderStatus.delivering:
          _data = state.listOrderDelivering;
          break;
      }
      if ((_data.results ?? []).isEmpty) {
        return Center(
          child: ListEmptyWidget(
            title: 'key_no_order'.tr(),
            icon: AppAssets.orderIcon,
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: (_data.results ?? []).length,
        separatorBuilder: (_, __) => 12.h,
        itemBuilder: (context, index) {
          final order = (_data.results ?? [])[index];
          return SellerOrderItemWidget(orderItem: order);
        },
      );
    });
  }
}
