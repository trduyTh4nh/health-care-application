import 'dart:math';

import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/const/functions.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:flutter/material.dart';

class DrugToday extends StatefulWidget {
  const DrugToday({super.key});
  @override
  State<DrugToday> createState() => _DrugTodayState();
}

class _DrugTodayState extends State<DrugToday> with AutomaticKeepAliveClientMixin<DrugToday> {
  List<ScheduleDetailModel> mockData = List.generate(
      10,
      (e) => ScheduleDetailModel(
            idScheduleDetail: e,
            status: "not_done",
            timeOfUse: TimeOfDay(
                hour: Random().nextInt(24), minute: Random().nextInt(60)),
            detail: PrescriptionDetailModel(
                drug: DrugModel(name: "Paracetamol"),
                quantity: Random().nextInt(100),
                quantityUsed: 0,
                amountPerConsumption: Random().nextInt(10),
                notes: "Trước khi ăn"),
          ));
  List<ScheduleDetailModel> expiredData = [];
  List<ScheduleDetailModel> morningData = [];
  List<ScheduleDetailModel> eveningData = [];
  List<ScheduleDetailModel> noonData = [];
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    expiredData = mockData
        .where((e) => toSecond(e.timeOfUse!) < toSecond(TimeOfDay.now()))
        .toList();
    morningData = mockData
        .where((e) => (e.timeOfUse!.hour >= 0 && e.timeOfUse!.hour < 12) && !expiredData.contains(e))
        .toList();

    morningData.sort((a, b) => a.timeOfUse!.hour.compareTo(b.timeOfUse!.hour));

    noonData = mockData
        .where((e) => (e.timeOfUse!.hour > 12 && e.timeOfUse!.hour <= 18) && !expiredData.contains(e))
        .toList();
    noonData.sort((a, b) => a.timeOfUse!.hour.compareTo(b.timeOfUse!.hour));

    eveningData = mockData
        .where((e) => (e.timeOfUse!.hour > 18 && e.timeOfUse!.hour <= 24) && !expiredData.contains(e))
        .toList();
    eveningData.sort((a, b) => a.timeOfUse!.hour.compareTo(b.timeOfUse!.hour));
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.separated(
          itemCount: expiredData.length,
          itemBuilder: (context, index) => MedicationItem(
            prescription: expiredData[index],
            titleText: index == 0 ? "Quá giờ uống thuốc" : null,
          ),
          separatorBuilder: (context, index) => const Divider(
            indent: 20,
            endIndent: 20,
          ),
        ),
        SliverList.separated(
          itemCount: morningData.length,
          itemBuilder: (context, index) => MedicationItem(
            prescription: morningData[index],
            titleText: index == 0 ? "Sáng nay" : null,
          ),
          separatorBuilder: (context, index) => const Divider(
            indent: 20,
            endIndent: 20,
          ),
        ),
        SliverList.separated(
          itemCount: noonData.length,
          itemBuilder: (context, index) => MedicationItem(
            prescription: noonData[index],
            titleText: index == 0 ? "Chiều nay" : null,
          ),
          separatorBuilder: (context, index) => const Divider(
            indent: 20,
            endIndent: 20,
          ),
        ),
        SliverList.separated(
          itemCount: eveningData.length,
          itemBuilder: (context, index) => MedicationItem(
            prescription: eveningData[index],
            titleText: index == 0 ? "Tối nay" : null,
          ),
          separatorBuilder: (context, index) => const Divider(
            indent: 20,
            endIndent: 20,
          ),
        )
      ],
    );
  }
}
