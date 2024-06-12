import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
        actions: [
          TextButton(onPressed: () {}, child: Text("Xóa tất cả"))
        ],
      ),
      body: Container(
        child: Column(
          children: [const Text('Thông báo')],
        ),
      ),
    );
  }
}
