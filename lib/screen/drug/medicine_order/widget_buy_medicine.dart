import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/screen/drug_details.dart';
import 'package:app_well_mate/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<CartPageProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              itemCount: value.listChecked.length,
              itemBuilder: (context, index) {
                var item = value.listChecked[index];
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image),
                              // drug!.drugImage ?? ''
                              item.drug!.drugImage ?? '',
                              width: 50,
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        2 /
                                        3,
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      item.drug!.name!,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "${item.quantity} ${item.drug!.unit}- ${convertCurrency(item.drug!.price)}/${item.drug!.unit}")
                                    ],
                                  ),
                                  Text(convertCurrency(item.drug!.price),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}
