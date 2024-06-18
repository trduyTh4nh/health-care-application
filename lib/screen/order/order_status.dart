import 'package:flutter/material.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key});

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tình trạng đơn thuốc'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Text('Status Order'),
      ),
    );
  }
}
