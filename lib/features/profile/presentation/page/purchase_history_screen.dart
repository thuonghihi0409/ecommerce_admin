import 'package:flutter/material.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  // Sample data
  final List<Map<String, String>> deliveredOrders = [
    {'orderId': 'ORD12346', 'date': '2025-01-07', 'total': '750,000 VND'},
    {'orderId': 'ORD12347', 'date': '2025-01-06', 'total': '1,200,000 VND'},
  ];

  final List<Map<String, String>> deliveringOrders = [
    {'orderId': 'ORD12345', 'date': '2025-01-08', 'total': '500,000 VND'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lịch sử mua hàng'),
          bottom: TabBar(
            indicatorColor: Colors.blueAccent,
            indicatorWeight: 3,
           // labelColor: Colors.white,
           // unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Đã giao'),
              Tab(text: 'Đang giao'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrderListWidget(orders: deliveredOrders, emptyMessage: 'Không có đơn đã giao'),
            OrderListWidget(orders: deliveringOrders, emptyMessage: 'Không có đơn đang giao'),
          ],
        ),
      ),
    );
  }
}

class OrderListWidget extends StatelessWidget {
  final List<Map<String, String>> orders;
  final String emptyMessage;

  OrderListWidget({required this.orders, required this.emptyMessage});

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? Center(
      child: Text(
        emptyMessage,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    )
        : ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(order: order);
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final Map<String, String> order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mã đơn: ${order['orderId']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  order['date']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Tổng tiền: ${order['total']}',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Chi tiết đơn hàng: ${order['orderId']}')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Xem chi tiết'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
