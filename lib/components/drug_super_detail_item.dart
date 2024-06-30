import 'package:app_well_mate/components/custom_elevated_button.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/screen/drug_info.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

enum DrugSuperDetailItemAction { delete, hide }

class DrugSuperDetailComponent extends StatefulWidget {
  const DrugSuperDetailComponent({
    Key? key,
    required this.drug,
  }) : super(key: key);

  final DrugModel drug;

  @override
  State<DrugSuperDetailComponent> createState() =>
      _DrugSuperDetailComponentState();
}

class _DrugSuperDetailComponentState extends State<DrugSuperDetailComponent> {
  @override
  Widget build(BuildContext context) {
    Color accent = colorScheme.primary;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DrugInfoPage()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: accent,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Icon(Symbols.pill,
                                          color: colorScheme.surface),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    widget.drug.name ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  CustomElevatedButton(
                                    color: accent,
                                    onTap: () {},
                                    child: Icon(Icons.check,
                                        color: colorScheme.surface),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
              ),
            ),
            PopupMenuButton(
              icon: const Icon(Symbols.more_horiz),
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: DrugSuperDetailItemAction.delete,
                  child: ListTile(
                    leading: Icon(Symbols.delete),
                    title: Text('Xóa'),
                  ),
                ),
                PopupMenuItem(
                  value: DrugSuperDetailItemAction.hide,
                  child: ListTile(
                    leading: Icon(Symbols.hide),
                    title: Text('Ẩn'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget checkPriorityForIcon(String priority) {
  switch (priority) {
    case 'overdue':
    case 'runoutof':
      return const Icon(
        Symbols.pill_off,
        color: Colors.white,
      );
    case 'delivery':
      return const Icon(
        Symbols.local_shipping,
        color: Colors.white,
      );
    case 'confirm':
      return const Icon(
        Symbols.stethoscope_check,
        color: Colors.white,
      );
    default:
      return const Icon(
        Symbols.pill,
        color: Colors.white,
      );
  }
}
