import 'package:app_well_mate/components/custom_elevated_button.dart';
import 'package:app_well_mate/const/functions.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/screen/drug/medicine_order/medicines_order_main.dart';
import 'package:app_well_mate/screen/drug_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm }

class MedicationItem extends StatefulWidget {
  const MedicationItem({super.key, required this.prescription, this.titleText});
  final ScheduleDetailModel prescription;
  //debug
  final String? titleText;
  @override
  State<MedicationItem> createState() => _MedicationItemState();
}

class _MedicationItemState extends State<MedicationItem> {
  bool showWarning = true;
  @override
  Widget build(BuildContext context) {
    int timeDiffSec = widget.prescription.timeOfUse != null
        ? (toSecond(TimeOfDay.now()) - toSecond(widget.prescription.timeOfUse!))
        : -1;
    TimeOfDay timeDiff = toTime(timeDiffSec.abs());
    Color accent = timeDiffSec > 0 && widget.prescription.status != "completed"
        ? colorScheme.error
        : colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: colorScheme.surface.withAlpha(150),
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              widget.titleText != null
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(
                          20, widget.titleText != null ? 20 : 20, 20, 20),
                      child: Text(
                        widget.titleText ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold),
                      ))
                  : const SizedBox(),
              InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DrugInfoPage(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: accent,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Icon(Symbols.pill,
                                        color: colorScheme.surface),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  // tên thuốc
                                  child: Text(
                                    widget.prescription.detail!.drug!.name ??
                                        "",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    widget.prescription.status != "completed"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              widget.prescription
                                                          .idScheduleDetail !=
                                                      null
                                                  ? CustomElevatedButton(
                                                      color: accent,
                                                      onTap: () {},
                                                      child: Icon(
                                                        Icons.check,
                                                        color:
                                                            colorScheme.surface,
                                                      ))
                                                  : const SizedBox(),
                                              timeDiffSec > 0
                                                  ? Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        CustomElevatedButton(
                                                            color: accent,
                                                            onTap: () {},
                                                            child: Icon(
                                                              Icons.snooze,
                                                              color: colorScheme
                                                                  .surface,
                                                            )),
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          )
                                        : widget.prescription.detail!
                                                    .quantityUsed ==
                                                0
                                            ? CustomElevatedButton(
                                                color: colorScheme.error,
                                                onTap: () {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           const MedicinesOrder(),
                                                  //     ));
                                                },
                                                child: const Icon(
                                                  Icons.add_shopping_cart,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const SizedBox(),
                                  ],
                                ),
                                PopupMenuButton(
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        enabled: widget.prescription
                                                .idScheduleDetail !=
                                            null,
                                        value: MedicationItemAction.confirm,
                                        child: const ListTile(
                                            leading: Icon(Symbols.check),
                                            title: Text("Xác nhận đã uống"))),
                                    PopupMenuItem(
                                        enabled: widget.prescription
                                                .idScheduleDetail !=
                                            null,
                                        value: MedicationItemAction.snooze,
                                        child: const ListTile(
                                            leading: Icon(Symbols.snooze),
                                            title:
                                                Text("Nhắc tôi sau 10p nữa"))),
                                    const PopupMenuItem(
                                        value: MedicationItemAction.buy,
                                        child: ListTile(
                                            leading: Icon(Symbols.shopping_bag),
                                            title: Text("Thêm vào giỏ hàng"))),
                                    const PopupMenuItem(
                                        value: MedicationItemAction.edit,
                                        child: ListTile(
                                            leading: Icon(Symbols.edit),
                                            title: Text("Sửa thuốc này"))),
                                    const PopupMenuItem(
                                        value: MedicationItemAction.delete,
                                        child: ListTile(
                                            leading: Icon(Symbols.delete),
                                            title: Text("Xoá thuốc này"))),
                                  ],
                                  onSelected: (value) {
                                    switch (value) {
                                      case MedicationItemAction.buy:
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           const MedicinesOrder(),
                                        //     ));
                                        Provider.of<CartPageProvider>(context,
                                                listen: false)
                                            .addDrugCart(
                                                widget.prescription.detail!);
                                        break;
                                      case MedicationItemAction.delete:
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AlertDialog.adaptive(
                                                  title: const Text(
                                                      "Xoá thuốc này"),
                                                  content: Text(
                                                      "Bạn có muốn xoá thuốc ${widget.prescription.detail!.drug!.name} không?"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("Có")),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("Không"))
                                                  ],
                                                ));
                                        break;
                                      default:
                                        break;
                                    }
                                  },
                                )
                              ])
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Symbols.alarm),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    "Ngày ${widget.prescription.detail!.amountPerConsumption} ${widget.prescription.detail!.drug!.unit}")
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          //đừng có const :)
                          const Expanded(
                            child: Row(
                              children: [
                                Icon(Symbols.local_dining),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Trước khi ăn")
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Symbols.pill),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    "${widget.prescription.detail!.quantityUsed}/${widget.prescription.detail!.quantity}")
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          //đừng có const :)
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.prescription.status != null
                                        ? widget.prescription.status!
                                                    .toLowerCase() ==
                                                "completed"
                                            ? "Đã uống"
                                            : timeDiffSec > 0
                                                ? "Trễ ${timeDiff.hour} giờ, ${timeDiff.minute} phút"
                                                : "Còn ${timeDiff.hour} giờ, ${timeDiff.minute} phút"
                                        : "",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      widget.prescription.detail!.quantityUsed == 0 &&
                              showWarning
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Material(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: colorScheme.errorContainer,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 10, 10, 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(
                                          child: Row(
                                            children: [
                                              Icon(Symbols.emergency_home),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                      "Đã hết thuốc, hãy mua thêm")),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showWarning = false;
                                              });
                                            },
                                            icon: const Icon(Icons.close),
                                            style: ButtonStyle(
                                              padding: WidgetStateProperty.all(
                                                  EdgeInsets.all(0)),
                                            ))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
