import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/payment_model.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransactionHistoryItem extends StatefulWidget {
  const TransactionHistoryItem({super.key, required this.data});
  final PaymentModel data;
  @override
  State<TransactionHistoryItem> createState() => _TransactionHistoryItemState();
}

class _TransactionHistoryItemState extends State<TransactionHistoryItem> {
  DateFormat format = DateFormat("dd/MM/yyyy HH:mm");
  late Color primaryColor =
      widget.data.status! ? AppColors.primaryColor : colorScheme.error;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
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
                          borderRadius: const BorderRadius.all(Radius.circular(50))),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: SizedBox(
                            width: 24,
                            height: 24,
                            child: Icon(Symbols.attach_money, color: AppColors.backgroundColor,)),
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
                                  "Giao dịch lúc ${format.format(widget.data.datePay ?? DateTime.now())}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                          Text(
                              "${widget.data.order!.orderDetailList!.length} thuốc • ${widget.data.paymentMethod}"),
                          Text("${widget.data.totalMoney}"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text(
                widget.data.status! ? "Thành công" : "Thất bại",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: primaryColor),
              )
            ],
          )),
    );
  }
}
