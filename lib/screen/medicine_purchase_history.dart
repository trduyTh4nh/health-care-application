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
    return Stack(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: colorScheme.surface),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff6a94ff), Colors.white],
          )),
          height: MediaQuery.of(context).size.height * 1 / 2,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: colorScheme.surface.withAlpha(100),
            title: const Text("Đặt mua thuốc"),
          ),
          body:  Padding(
            padding: EdgeInsets.all(12),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     PurchaseHistoryItem(),
            //     Divider(),
            //     SizedBox(
            //       height: 16,
            //     ),
            //     PurchaseHistoryItem(),
            //     Divider(),
            //     SizedBox(
            //       height: 16,
            //     ),
            //     PurchaseHistoryItem(),
            //   ],
            // ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: ListView.separated(
                itemBuilder:(context, index) {
                return PurchaseHistoryItem();
              }, separatorBuilder:(context, index) 
              => const Divider(), itemCount: 3,),
            )
          ),
        ),
      ]
    );
  }
}
