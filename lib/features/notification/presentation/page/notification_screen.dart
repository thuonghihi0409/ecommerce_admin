import 'package:flutter/material.dart';
import 'package:thuongmaidientu/features/notification/presentation/widget/notification_item_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Số lượng thông báo
        itemBuilder: (context, index) {
          return NotificationCard(
            title: 'Thông báo $index',
            description: 'Mô tả chi tiết về thông báo $index.',
            timestamp: '5 phút trước',
          );
        },
      ),
    );
  }
}
