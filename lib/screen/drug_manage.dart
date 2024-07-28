import 'package:app_well_mate/api/application/application_repo.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:app_well_mate/screen/drug/schedule_pages/all_drug.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DrugManagePage extends StatefulWidget {
  const DrugManagePage({super.key});

  @override
  State<DrugManagePage> createState() => _DrugManagePageState();
}

class _DrugManagePageState extends State<DrugManagePage> {
  List<PrescriptionModel>? lst = [];
  bool isError = false;
  PrescriptionModel? selected;
  ApplicationRepo repo = ApplicationRepo();
  getData() async {
    lst = await repo.getPrescription();
  }

  Future<void>? future;
  @override
  void initState() {
    future = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quản lý thuốc")),
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.flickr(
                    leftDotColor: colorScheme.primary,
                    rightDotColor: colorScheme.error,
                    size: 48),
              );
            }
            selected ??= lst![0];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text("Đơn thuốc"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Material(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.circular(16),
                    child: DropdownButton(
                        borderRadius: BorderRadius.circular(16),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        underline: const SizedBox(),
                        isExpanded: true,
                        value: selected,
                        items: lst!
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Row(
                                  children: [
                                    const Icon(Icons.receipt_long),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                            "Bác sĩ ${e.doctorName} ngày ${DateFormat("dd/MM/yyyy").format(e.createdDate!)}"))
                                  ],
                                )))
                            .toList(),
                        onChanged: (PrescriptionModel? v) {
                          setState(() {
                            selected = v;
                          });
                        }),
                  ),
                ),
                const Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                Expanded(child: AllDrug(prescriptionId: selected!.idPre!,)),
              ],
            );
          }),
    );
  }
}
