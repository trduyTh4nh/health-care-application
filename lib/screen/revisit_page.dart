import 'dart:math';

import 'package:app_well_mate/components/revisit_date.dart';
import 'package:app_well_mate/model/hospital_model.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:flutter/material.dart';

class RevisitPage extends StatefulWidget {
  const RevisitPage({super.key});

  @override
  State<RevisitPage> createState() => _RevisitPageState();
}

class _RevisitPageState extends State<RevisitPage> {
  final List<PrescriptionModel> _schedules = List.generate(
      20,
      (e) => PrescriptionModel(
          idPre: e,
          idUser: 0,
          idHospital: 0,
          revisitDate:
              DateTime(2024, Random().nextInt(12), Random().nextInt(28)),
          createdDate: DateTime.now(),
          status: "not_done",
          hospital: HospitalModel(idHospital: 0, name: "Phòng khám ABC"),
          roomRevisit: "D12"));
  List<PrescriptionModel> _scheduleExpired = [];
  List<PrescriptionModel> _scheduleLastWeek = [];
  List<PrescriptionModel> _scheduleLastMonth = [];
  List<PrescriptionModel> _scheduleOthers = [];
  List<PrescriptionModel> _scheduleUpcoming = [];

  @override
  void initState() {
    _scheduleExpired = _schedules
        .where((e) => DateTime.now().compareTo(e.revisitDate!) == 1)
        .toList();
    _scheduleLastWeek = _schedules
        .where((e) =>
            -DateTime.now().difference(e.revisitDate!).inDays <= 2 &&
            !_scheduleExpired.contains(e))
        .toList();
    _scheduleLastWeek = _schedules
        .where((e) =>
            -DateTime.now().difference(e.revisitDate!).inDays <= 7 &&
            -DateTime.now().difference(e.revisitDate!).inDays > 2 &&
            !_scheduleExpired.contains(e))
        .toList();
    _scheduleLastMonth = _schedules
        .where((e) =>
            -DateTime.now().difference(e.revisitDate!).inDays <= 30 &&
            -DateTime.now().difference(e.revisitDate!).inDays > 7 &&
            !_scheduleExpired.contains(e))
        .toList();
    _scheduleOthers = _schedules
        .where((e) =>
            -DateTime.now().difference(e.revisitDate!).inDays > 30 &&
            !_scheduleExpired.contains(e))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch tái khám"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.separated(
            itemCount: _scheduleExpired.length,
            itemBuilder: (context, index) => RevisitDate(
                titleText: index == 0 ? "Quá thời hạn tái khám" : null,
                prescription: _scheduleExpired[index]),
            separatorBuilder: (context, index) => const Divider(
              indent: 20,
              endIndent: 20,
            ),
          ),
          SliverList.separated(
            itemCount: _scheduleUpcoming.length,
            itemBuilder: (context, index) => RevisitDate(
                titleText: index == 0 ? "Sắp tới" : null,
                prescription: _scheduleUpcoming[index]),
            separatorBuilder: (context, index) => const Divider(
              indent: 20,
              endIndent: 20,
            ),
          ),
          SliverList.separated(
            itemCount: _scheduleLastWeek.length,
            itemBuilder: (context, index) => RevisitDate(
                titleText: index == 0 ? "Tuần sau" : null,
                prescription: _scheduleLastWeek[index]),
            separatorBuilder: (context, index) => const Divider(
              indent: 20,
              endIndent: 20,
            ),
          ),
          SliverList.separated(
            itemCount: _scheduleLastMonth.length,
            itemBuilder: (context, index) => RevisitDate(
                titleText: index == 0 ? "Tháng sau" : null,
                prescription: _scheduleLastMonth[index]),
            separatorBuilder: (context, index) => const Divider(
              indent: 20,
              endIndent: 20,
            ),
          ),
          SliverList.separated(
            itemCount: _scheduleOthers.length,
            itemBuilder: (context, index) => RevisitDate(
                titleText: index == 0 ? "Khác" : null,
                prescription: _scheduleOthers[index]),
            separatorBuilder: (context, index) => const Divider(
              indent: 20,
              endIndent: 20,
            ),
          )
        ],
      ),
    );
  }
}
