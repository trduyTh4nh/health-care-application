import 'package:app_well_mate/components/custom_elevated_button.dart';
import 'package:app_well_mate/components/medication_detail_item.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:app_well_mate/screen/drug_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

class RevisitDate extends StatefulWidget {
  const RevisitDate({super.key, required this.prescription, this.titleText});
  final PrescriptionModel prescription;
  final String? titleText;

  @override
  State<RevisitDate> createState() => _RevisitDateState();
}

class _RevisitDateState extends State<RevisitDate> {
  Color accent = colorScheme.primary;
  DateFormat df = DateFormat("dd/MM/yyyy");
  bool isExpired = false;
    @override
  void initState() {
    isExpired = DateTime.now().compareTo(widget.prescription.revisitDate!) == 1;
    accent = isExpired ? colorScheme.error : colorScheme.primary;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var dateDif =
        DateTime.now().difference(widget.prescription.revisitDate!).inDays;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      widget.titleText != null
          ? Padding(
              padding: EdgeInsets.fromLTRB(
                  20, widget.titleText != null ? 10 : 0, 20, 0),
              child: Text(
                widget.titleText ?? "",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontFamily: "Inter", fontWeight: FontWeight.bold),
              ))
          : const SizedBox(),
      InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DrugInfoPage(),
                ));
          },
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: Column(children: [
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Icon(Symbols.restart_alt,
                                    color: colorScheme.surface),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tái khám ở ${widget.prescription.hospital!.name}",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                      "Ngày ${dateDif == 1 ? "hôm qua" : dateDif == -1 ? "mai" : df.format(widget.prescription.revisitDate!)} (${isExpired ? "quá $dateDif" : "còn ${-dateDif}"} ngày)"),
                                  Text(
                                      "Phòng ${widget.prescription.roomRevisit}")
                                ],
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CustomElevatedButton(
                                                color: accent,
                                                onTap: () {},
                                                child: Icon(
                                                  Icons.check,
                                                  color: colorScheme.surface,
                                                )),
                                          ])
                                    ],
                                  ),
                                  PopupMenuButton(
                                    itemBuilder: (context) => const [
                                      PopupMenuItem(
                                          value: MedicationItemAction.confirm,
                                          child: ListTile(
                                              leading: Icon(Symbols.check),
                                              title: Text("Xác nhận đã khám"))),
                                      PopupMenuItem(
                                          value: MedicationItemAction.snooze,
                                          child: ListTile(
                                              leading: Icon(Symbols.snooze),
                                              title: Text(
                                                  "Nhắc tôi sau 10p nữa"))),
                                    ],
                                  )
                                ]),
                          ]))
                    ])
              ])))
    ]);
  }
}
