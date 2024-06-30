import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/const/functions.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'dart:math';

class DrugSuperDetail extends StatefulWidget {
  const DrugSuperDetail({super.key});

  @override
  State<DrugSuperDetail> createState() => _DrugSuperDetailState();
}

class _DrugSuperDetailState extends State<DrugSuperDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ScheduleDetailModel> mockData = List.generate(
      100,
      (e) => ScheduleDetailModel(
            idScheduleDetail: e,
            status: "not_done",
            timeOfUse: TimeOfDay(
                hour: Random().nextInt(24), minute: Random().nextInt(60)),
            detail: PrescriptionDetailModel(
                drug: DrugModel(name: "Paracetamol"),
                quantity: Random().nextInt(100),
                quantityUsed: Random().nextInt(100),
                amountPerConsumption: Random().nextInt(10),
                notes: "Trước khi ăn"),
          ));
  List<ScheduleDetailModel> expiredData = [];
  List<ScheduleDetailModel> upcomingData = [];
  List<ScheduleDetailModel> afternoonData = [];
  @override
  void initState() {
    super.initState();
    expiredData = mockData
        .where((e) => toSecond(e.timeOfUse!) < toSecond(TimeOfDay.now()))
        .toList();
    upcomingData = mockData
        .where((e) =>
            toSecond(TimeOfDay.now()) - toSecond(e.timeOfUse!) > -3600 &&
            toSecond(TimeOfDay.now()) - toSecond(e.timeOfUse!) < 0)
        .toList();
    afternoonData = mockData.where((e) {
      int seconds = toSecond(e.timeOfUse!);
      int noon = toSecond(const TimeOfDay(hour: 12, minute: 0));
      int evening = toSecond(const TimeOfDay(hour: 18, minute: 0));
      return seconds >= noon && seconds < evening;
    }).toList();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('03/02/2023 - Chi Tiết'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryColor,
          indicatorColor: AppColors.primaryColor,
          unselectedLabelColor: Colors.black,
          indicatorWeight: 2.0,
          tabs: [
            Stack(
              children: [
                const Tab(text: 'Thuốc chưa uống'),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const Tab(text: 'Thuốc đã uống'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: CustomScrollView(
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
                  itemCount: upcomingData.length,
                  itemBuilder: (context, index) => MedicationItem(
                    prescription: upcomingData[index],
                    titleText: index == 0 ? "Sắp tới" : null,
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
                SliverList.separated(
                  itemCount: afternoonData.length,
                  itemBuilder: (context, index) => MedicationItem(
                    prescription: afternoonData[index],
                    titleText: index == 0 ? "Chiều nay" : null,
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: const Center(
              child: Text(
                "Danh sách thuốc đã uống",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
