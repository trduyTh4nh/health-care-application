import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class DrugItem extends StatefulWidget {
  const DrugItem({super.key, required this.drugModel});
  final DrugModel drugModel;

  @override
  State<DrugItem> createState() => _DrugItemState();
}

class _DrugItemState extends State<DrugItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                backgroundImage: NetworkImage(widget.drugModel.drugImage ?? ""),
                onBackgroundImageError: (exception, stackTrace) => const Icon(Symbols.pill),
              ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.drugModel.name ?? "",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${NumberFormat("##,###.##").format(widget.drugModel.price)} đồng / ${widget.drugModel.unit}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          // ElevatedButton(
          //     onPressed: () {},
          //     child: Text('Mua ngay'),
          //     style: ElevatedButton.styleFrom(
          //         minimumSize: const Size(100, 40),
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(100)))),
          // PopupMenuButton(
          //   itemBuilder: (context) => const [
          //     PopupMenuItem(
          //         value: MedicationItemAction.delete,
          //         child: ListTile(
          //           leading: Icon(Symbols.delete),
          //           title: Text('Xóa thuốc'),
          //         ))
          //   ],
          // )
        ],
      ),
    );
  }
}
