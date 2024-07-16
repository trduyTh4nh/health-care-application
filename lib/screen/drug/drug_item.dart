import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:flutter/material.dart';
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
                Container(
                  padding: const EdgeInsets.all(16),
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColor.gray,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.network(
                      'https://cdn.nhathuoclongchau.com.vn/unsafe/375x0/filters:quality(90)/https://cms-prod.s3-sgn09.fptcloud.com/00005713_panadol_extra_do_500mg_180v_sanofi_3541_63d7_large_72b42bbdda.jpg'),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Panadon Extra',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '3 vỉ - 8000đ/vỉ',
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
