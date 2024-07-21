import 'dart:math';

import 'package:app_well_mate/api/drug/drug_repo.dart';
import 'package:app_well_mate/components/info_component.dart';
import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DrugDone extends StatefulWidget {
  const DrugDone({super.key});

  @override
  State<DrugDone> createState() => _DrugDoneState();
}

class _DrugDoneState extends State<DrugDone> {
  List<ScheduleDetailModel>? mockData = [];
  DrugRepo repo = DrugRepo();
  getData() async {
    mockData = await repo.getLog();
  }

  Future<void>? future;
  @override
  void initState() {
    future = getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: LoadingAnimationWidget.flickr(
              leftDotColor: colorScheme.primary,
              rightDotColor: colorScheme.error,
              size: 48,
            ));
          }
          if(mockData == null){
            return const Center(
              child: ErrorInfo(
                title: "Lỗi hệ thống",
                subtitle: "Chúng tôi đang bị trục trặc do lỗi hệ thống, vui lòng thử lại sau",
                icon: Icons.error_outline,
              ),
            );
          }
          if(mockData!.isEmpty){
            return const Center(
              child: ErrorInfo(
                title: "Hãy bắt đầu",
                subtitle: "Hãy bắt đầu",
                icon: Icons.star_border,
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 20 + 16 + 32),
            itemCount: mockData!.length,
            itemBuilder: (context, index) =>
                MedicationItem(prescription: mockData![index]),
            separatorBuilder: (context, index) => const Divider(
              indent: 20,
              endIndent: 20,
            ),
          );
        });
  }
}
