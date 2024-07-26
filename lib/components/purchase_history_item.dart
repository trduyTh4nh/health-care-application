import 'package:app_well_mate/model/history_stransaction_model.dart';
import 'package:app_well_mate/screen/drug/medicine_order/widget_prescriptionstatus_cancel_medicine.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:timezone/timezone.dart' as tz;

class PurchaseHistoryItem extends StatefulWidget {
  const PurchaseHistoryItem({super.key, required this.model});
  final HistoryStransactionModel model;
  @override
  State<PurchaseHistoryItem> createState() => _PurchaseHistoryItemState();
}

class _PurchaseHistoryItemState extends State<PurchaseHistoryItem> {
  @override
  Widget build(BuildContext context) {
    tz.TZDateTime zonedDate =
        tz.TZDateTime.parse(tz.local, widget.model.createDate!);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WidgetPrescriptionstatusCancelMedicine(
                      model: widget.model,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.greyColor,
              child: Icon(
                Icons.receipt_long,
                color: Colors.black87,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.model.idPayPal}',
                      style: Theme.of(context).textTheme.bodyLarge),
                  Text(
                    '${widget.model.countDrug} thuốc • ${DateFormat("dd/MM/yyyy").format(zonedDate)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    NumberFormat("##,###.##").format(widget.model.totalPrice),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(widget.model.isDestroy! ? Symbols.close : widget.model.status!
                      ? Symbols.check_circle
                      : Symbols.deployed_code_history),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
