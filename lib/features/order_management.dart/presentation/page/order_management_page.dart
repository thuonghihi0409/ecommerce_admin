import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/order_management.dart/domain/entities/seller_order_item.dart';
import 'package:thuongmaidientu/features/order_management.dart/presentation/bloc/order_management_bloc/order_management_bloc.dart';
import 'package:thuongmaidientu/features/order_management.dart/presentation/page/seller_order_list_tab.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';

class OrderManagementPage extends StatefulWidget {
  const OrderManagementPage({super.key});

  @override
  State<OrderManagementPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderManagementPage>
    with TickerProviderStateMixin {
  late OrderManagementBloc _bloc;
  final List<OrderStatus> _tabs = [
    OrderStatus.pending,
    OrderStatus.awaiting,
    OrderStatus.delivering,
    OrderStatus.delivered,
    OrderStatus.cancelled,
  ];

  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
    _bloc = BlocProvider.of<OrderManagementBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: const CustomAppBar(
        title: "Đơn hàng",
        showLeading: false,
      ),
      body: Column(
        children: [
          Container(
            color: AppColor.primary.withAlpha(20),
            child: TabBar(
              tabAlignment: TabAlignment.start,
              padding: EdgeInsets.zero,
              controller: _tabController,
              isScrollable: true,
              indicatorColor: AppColor.primary,
              labelColor: AppColor.primary,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              tabs: _tabs.map((e) => Tab(text: orderStatusToText(e))).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabs.map((status) {
                return SellerOrderListTab(status: status);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
