import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/history_stransaction_model.dart';
import 'package:app_well_mate/model/payment_model.dart';
import 'package:app_well_mate/screen/transaction_detail.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionHistoryItem extends StatefulWidget {
  const TransactionHistoryItem({super.key, required this.data});
  // final PaymentModel data;
  final HistoryStransactionModel data;
  @override
  State<TransactionHistoryItem> createState() => _TransactionHistoryItemState();
}

class _TransactionHistoryItemState extends State<TransactionHistoryItem> {
  DateFormat format = DateFormat("dd/MM/yyyy HH:mm");
  NumberFormat numFormat = NumberFormat("##,###.##");
  late Color primaryColor =
       AppColors.primaryColor ;

  @override
  Widget build(BuildContext context) {
    String displayDate;
    try {
      // If createDate is null or empty, use a default value or an empty string
      DateTime date =
          widget.data.createDate != null && widget.data.createDate!.isNotEmpty
              ? DateTime.parse(widget.data.createDate!)
              : DateTime.now(); // or provide another default date
      displayDate = format.format(date);
    } catch (e) {
      displayDate = 'Ngày không hợp lệ'; // Provide an error message
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(
                            Symbols.attach_money,
                            color: AppColors.backgroundColor,
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                // "Giao dịch lúc ${format.format(widget.data.createDate ?? DateTime.now())}",
                                "Giao dịch lúc $displayDate",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                        Text("${numFormat.format(widget.data.totalPrice)} ₫"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            
          ],
        ));
  }
}
