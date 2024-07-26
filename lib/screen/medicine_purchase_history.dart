import 'package:app_well_mate/api/payment/payment_repo.dart';
import 'package:app_well_mate/components/info_component.dart';
import 'package:app_well_mate/components/purchase_history_item.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/history_stransaction_model.dart';
import 'package:app_well_mate/model/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class MedicinePurchaseHistory extends StatefulWidget {
  const MedicinePurchaseHistory({super.key});

  @override
  State<MedicinePurchaseHistory> createState() =>
      _MedicinePurchaseHistoryState();
}

class _MedicinePurchaseHistoryState extends State<MedicinePurchaseHistory> {
  List<HistoryStransactionModel> lst = [];
  PaymentRepo repo = PaymentRepo();
  getData() async {
    lst = await repo.getAllInvoicesBy();
    lst.sort((a, b) => -((a.status! ? 1 : 0) - (b.status! ? 1 : 0)));
  }

  Future<void>? future;
  @override
  void initState() {
    future = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface.withAlpha(100),
        title: const Text("Danh sách đơn mua thuốc"),
      ),
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.flickr(
                    leftDotColor: colorScheme.primary,
                    rightDotColor: colorScheme.error,
                    size: 48),
              );
            }
            if (lst.isEmpty) {
              return const Center(
                child: ErrorInfo(
                  title: "Không có đơn mua thuốc nào",
                  subtitle: "Vui lòng mua thuốc để có thể quản lý các đơn mua.",
                  icon: Symbols.receipt_long,
                ),
              );
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                return PurchaseHistoryItem(model: lst[index]);
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: lst.length,
            );
          }),
    );
  }
}
