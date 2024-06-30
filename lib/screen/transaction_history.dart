import 'package:app_well_mate/components/transaction_history_item.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});
  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  List<PaymentModel> lst = generatePaymentList(20);
  DateTime date = DateTime.now();
  DateFormat format = DateFormat("dd/MM/yyyy");
  @override
  void initState() {
    lst.sort((e, e1) => e.status! ? 1 : 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch sử giao dịch"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(colorScheme.surfaceDim))
                    .copyWith(),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: colorScheme.onSurface,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      date == DateTime.now() ? "Hôm nay" : format.format(date),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList.separated(itemBuilder: (c,i) => TransactionHistoryItem(data: lst[i]), separatorBuilder: (c,i) => Divider(indent: 20, endIndent: 20,), itemCount: lst.length,)
        ],
      ),
    );
  }
}
