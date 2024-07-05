import 'package:app_well_mate/components/purchase_history_item.dart';
import 'package:flutter/material.dart';

class MedicinePurchaseHistory extends StatefulWidget {
  const MedicinePurchaseHistory({super.key});

  @override
  State<MedicinePurchaseHistory> createState() =>
      _MedicinePurchaseHistoryState();
}

class _MedicinePurchaseHistoryState extends State<MedicinePurchaseHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Đặt mua thuốc"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PurchaseHistoryItem(),
              Divider(),
              SizedBox(
                height: 16,
              ),
              PurchaseHistoryItem(),
              Divider(),
              SizedBox(
                height: 16,
              ),
              PurchaseHistoryItem(),
            ],
          ),
        ),
      ),
    );
  }
}
