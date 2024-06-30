import 'package:app_well_mate/screen/drug_details.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm, info }

class WidgetBuyMedicine extends StatefulWidget {
  const WidgetBuyMedicine({super.key});

  @override
  State<WidgetBuyMedicine> createState() => _WidgetBuyMedicine();
}

class _WidgetBuyMedicine extends State<WidgetBuyMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://i.giphy.com/BSx6mzbW1ew7K.webp'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Panadol Extra",
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text("3 vỉ _ 8.000 đ / vỉ",
                              style: Theme.of(context).textTheme.labelSmall),
                          Text("25.000 đ",
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ],
                ),
                PopupMenuButton(
                  style: Theme.of(context).iconButtonTheme.style,
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                        value: MedicationItemAction.delete,
                        child: ListTile(
                            leading: Icon(Symbols.delete),
                            title: Text("Xoá đơn thuốc "))),
                    PopupMenuItem(
                        value: MedicationItemAction.info,
                        child: ListTile(
                            leading: Icon(Symbols.info),
                            title: Text("Xem thông tin "))),
                  ],
                  onSelected: (value) {
                    switch (value) {
                      case MedicationItemAction.info:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Drugdetails(),
                            ));
                        break;
                      default:
                        break;
                    }
                  },
                ),
              ],
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
