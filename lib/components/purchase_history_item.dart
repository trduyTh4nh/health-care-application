import 'package:app_well_mate/screen/drug/medicine_order/widget_prescriptionstatus_cancel_medicine.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class PurchaseHistoryItem extends StatefulWidget {
  const PurchaseHistoryItem({super.key});

  @override
  State<PurchaseHistoryItem> createState() => _PurchaseHistoryItemState();
}

class _PurchaseHistoryItemState extends State<PurchaseHistoryItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const WidgetPrescriptionstatusCancelMedicine()));
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
                  Text('Đơn thuốc ngày 20-05-2024',
                      style: Theme.of(context).textTheme.bodyLarge),
                  Text(
                    '5 thuốc',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '505.000 đ',
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
                  icon: const Icon(Symbols.deployed_code_history),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
