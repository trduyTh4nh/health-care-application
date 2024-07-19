import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm, info }

class WidgetBuyMedicine extends StatelessWidget {
  final List<PrescriptionDetailModel> selectedDrugs;

  const WidgetBuyMedicine({required this.selectedDrugs, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: selectedDrugs.map((item) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: AppColors.greyColor,
                                            borderRadius: BorderRadius.circular(50)),
                                        child: Image.network(
                                          item.drug!.drugImage ?? '',
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.drug!.name ?? '',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "${item.quantity} vỉ - ${item.drug!.price ?? 0} đ / vỉ",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              "${(item.drug!.price ?? 0) * (item.quantity ?? 1)} đ",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                            value: MedicationItemAction.delete,
                            child: ListTile(
                              leading: Icon(Symbols.delete),
                              title: Text("Xoá đơn thuốc"),
                            ),
                          ),
                          PopupMenuItem(
                            value: MedicationItemAction.info,
                            child: ListTile(
                              leading: Icon(Symbols.info),
                              title: Text("Xem thông tin"),
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          // Handle actions
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
