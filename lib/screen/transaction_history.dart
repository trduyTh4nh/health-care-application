import 'package:app_well_mate/api/payment/payment_repo.dart';
import 'package:app_well_mate/components/transaction_history_item.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/history_stransaction_model.dart';
import 'package:app_well_mate/model/notification_model.dart';
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
  // List<PaymentModel> lst = generatePaymentList(20);
  Future<List<HistoryStransactionModel>>? fututeInvoices;

  DateTime date = DateTime.now();
  DateFormat format = DateFormat("dd/MM/yyyy");

  void loadInvoices([DateTime? selectedDate]) {
    setState(() {
      fututeInvoices = PaymentRepo().getAllInvoices(date: selectedDate);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != date) {
      setState(() {
        date = pickedDate;
        loadInvoices(pickedDate);
      });
    }
  }

  @override
  void initState() {
    // lst.sort((e, e1) => e.status! ? 1 : 0);
    // fututeInvoices = PaymentRepo().getAllInvoices();
    loadInvoices();

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
                onPressed: () => _selectDate(context),
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
          // SliverList.separated(itemBuilder: (c,i) => TransactionHistoryItem(data: lst[]), separatorBuilder: (c,i) => Divider(indent: 20, endIndent: 20,), itemCount: lst.length,)
          FutureBuilder<List<HistoryStransactionModel>>(
              future: fututeInvoices,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return const SliverFillRemaining(
                    child: Center(
                        child: Text("Không có giao dịch nào được thực hiện!")),
                  );
                } else {
                  return SliverList.separated(
                    itemBuilder: (context, index) =>
                        TransactionHistoryItem(data: snapshot.data![index]),
                    separatorBuilder: (context, index) => const Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    itemCount: snapshot.data!.length,
                  );
                }
              })
        ],
      ),
    );
  }
}
