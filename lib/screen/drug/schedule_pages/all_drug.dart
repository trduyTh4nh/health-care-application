import 'dart:math';

import 'package:app_well_mate/api/drug/drug_repo.dart';
import 'package:app_well_mate/components/info_component.dart';
import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class AllDrug extends StatefulWidget {
  const AllDrug({super.key, this.prescriptionId = -1});
  final int prescriptionId;
  @override
  State<AllDrug> createState() => _AllDrugState();
}

class _AllDrugState extends State<AllDrug> {
  List<ScheduleDetailModel>? data = [];
  DrugRepo repo = DrugRepo();
  getData() async {
    data = await repo.getPreDetail(widget.prescriptionId);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.flickr(
                leftDotColor: colorScheme.primary,
                rightDotColor: colorScheme.error,
                size: 48,
              ),
            );
          }
          if (data == null) {
            return const Center(
              child: Text("Lỗi"),
            );
          }
          if (data!.isEmpty) {
            return Center(
              child: ErrorInfo(
                title: "Không có thuốc",
                subtitle: "Hãy thêm thuốc bằng cách ấn vào biểu tượng ở góc phải màn hình",
                icon: Symbols.pill_off,
              )
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 20 + 16 + 32),
            itemCount: data!.length,
            itemBuilder: (context, index) =>
                MedicationItem(prescription: data![index]),
            separatorBuilder: (context, index) => const Divider(
              indent: 20,
              endIndent: 20,
            ),
          );
        });
  }
}
