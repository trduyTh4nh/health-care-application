import 'package:app_well_mate/components/purchase_history_item.dart';
import 'package:app_well_mate/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        backgroundColor: colorScheme.surface.withAlpha(100),
        title: const Text("Đơn mua thuốc"),
      ),
      body:  ListView.separated(
        itemBuilder:(context, index) {
        return PurchaseHistoryItem();
      }, separatorBuilder:(context, index) 
      => const Divider(), itemCount: 3,),
    );
  }
}
