import 'dart:math';

import 'package:app_well_mate/api/drug/drug_repo.dart';
import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/const/functions.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DrugToday extends StatefulWidget {
  const DrugToday({super.key, this.idPre = -1});
  final int idPre;
  @override
  State<DrugToday> createState() => _DrugTodayState();
}

class _DrugTodayState extends State<DrugToday>
    with AutomaticKeepAliveClientMixin<DrugToday> {
  List<ScheduleDetailModel> mockData = [];
  List<ScheduleDetailModel> expiredData = [];
  List<ScheduleDetailModel> morningData = [];
  List<ScheduleDetailModel> eveningData = [];
  List<ScheduleDetailModel> noonData = [];
  DrugRepo repo = DrugRepo();
  getData() async {
    mockData = await repo.getScheduleBy(widget.idPre);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              mockData.isEmpty) {
            return Center(
                child: LoadingAnimationWidget.flickr(
              leftDotColor: colorScheme.primary,
              rightDotColor: colorScheme.error,
              size: 48,
            ));
          }
          expiredData = mockData
              .where((e) => toSecond(e.timeOfUse!) < toSecond(TimeOfDay.now()))
              .toList();
          morningData = mockData
              .where((e) =>
                  (e.timeOfUse!.hour >= 0 && e.timeOfUse!.hour < 12) &&
                  !expiredData.contains(e))
              .toList();

          morningData
              .sort((a, b) => a.timeOfUse!.hour.compareTo(b.timeOfUse!.hour));

          noonData = mockData
              .where((e) =>
                  (e.timeOfUse!.hour > 12 && e.timeOfUse!.hour <= 18) &&
                  !expiredData.contains(e))
              .toList();
          noonData
              .sort((a, b) => a.timeOfUse!.hour.compareTo(b.timeOfUse!.hour));

          eveningData = mockData
              .where((e) =>
                  (e.timeOfUse!.hour > 18 && e.timeOfUse!.hour <= 24) &&
                  !expiredData.contains(e))
              .toList();
          eveningData
              .sort((a, b) => a.timeOfUse!.hour.compareTo(b.timeOfUse!.hour));
          if (mockData.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "🙌",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 100),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Làm tốt lắm!",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Text(
                      "Bạn đã hoàn thành đợt thuốc ngày hôm nay!",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverList.separated(
                itemCount: expiredData.length,
                itemBuilder: (context, index) => MedicationItem(
                  onUpdate: (scheid) {
                    onUpdate(scheid);
                  },
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
                  onUpdate: (scheid) {
                    onUpdate(scheid);
                  },
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
                  onUpdate: (scheid) {
                    onUpdate(scheid);
                  },
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
                  onUpdate: (scheid) {
                    onUpdate(scheid);
                  },
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
        });
  }

  void onUpdate(int scheid) {
    setState(() {
      mockData.removeWhere((e) => e.idScheduleDetail == scheid);
    });
  }

  void onDelete(int id, BuildContext context) {
    setState(() {
      mockData.removeWhere((e) => e.detail!.idPreDetail == id);
    });
  }
}
