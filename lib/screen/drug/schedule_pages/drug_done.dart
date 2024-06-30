import 'dart:math';

import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:flutter/material.dart';

class DrugDone extends StatefulWidget {
  const DrugDone({super.key});

  @override
  State<DrugDone> createState() => _DrugDoneState();
}

class _DrugDoneState extends State<DrugDone> with AutomaticKeepAliveClientMixin<DrugDone> {
  List<ScheduleDetailModel> mockData = List.generate(
      10,
      (e) => ScheduleDetailModel(
            idScheduleDetail: e,
            status: "completed",
            timeOfUse: TimeOfDay(
                hour: TimeOfDay.now().hour - Random().nextInt(5),
                minute: Random().nextInt(60)),
            detail: PrescriptionDetailModel(
                drug: DrugModel(name: "Paracetamol"),
                quantity: Random().nextInt(100),
                quantityUsed: 0,
                amountPerConsumption: Random().nextInt(10),
                notes: "Trước khi ăn"),
          ));
          @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 20+16 + 32),
      itemCount: mockData.length,
      itemBuilder: (context, index) =>
          MedicationItem(prescription: mockData[index]),
      separatorBuilder: (context, index) => Divider(indent: 20, endIndent: 20,),
    );
  }
}
