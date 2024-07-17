import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/utils/app.colors.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm, info }

class WidgetCompleteMedicine extends StatefulWidget {
  final List<PrescriptionDetailModel> selectedDrugs;
  
  const WidgetCompleteMedicine({required this.selectedDrugs, Key? key}) : super(key: key);

  @override
  State<WidgetCompleteMedicine> createState() => _WidgetCompleteMedicineState();
}

class _WidgetCompleteMedicineState extends State<WidgetCompleteMedicine> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Đơn thuốc đang được chuẩn bị bởi nhà thuốc",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 24),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: sizeHeight * 0.40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: widget.selectedDrugs.map((item) {
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
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                          Text(
                                            "${item.quantity} vỉ - ${item.drug!.price ?? 0} đ / vỉ",
                                            style: Theme.of(context).textTheme.titleMedium,
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
                  ),
                ],
              ),
            ),
          ),
          Material(
            elevation: 50,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text("Phương thức thanh toán"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGxsoe7iPccCnGraliGFCLCvbg3bO3PDtELQ&s"),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Visa",
                                  style:
                                      Theme.of(context).textTheme.titleMedium
                                      ),
                              Text("******12"),
                            ],
                          )
                        ],
                      ),
                      
                    ],
                  ),
                  Text("Địa chỉ giao hàng"),
                  Text(
                    "100 đường Example, Thành phố Hồ Chí Minh, Việt Nam",
                    style:
                        Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
