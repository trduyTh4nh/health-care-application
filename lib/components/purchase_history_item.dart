import 'package:app_well_mate/screen/drug/medicine_order/widget_prescriptionstatus_cancel_medicine.dart';
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Color(0xFFCBC9C9),
            child: Icon(
              Icons.receipt_long,
              size: 35,
              color: Colors.black,
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
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '5 thuốc',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 4,
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
                iconSize: 32,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Symbols.arrow_right_alt),
                iconSize: 32,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
