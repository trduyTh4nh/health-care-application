import 'package:app_well_mate/components/fab_menu_button.dart';
import 'package:app_well_mate/components/medication_fab.dart';
import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/screen/drug/add_drug.dart';
import 'package:app_well_mate/screen/drug/schedule_pages/all_drug.dart';
import 'package:app_well_mate/screen/drug/schedule_pages/drug_done.dart';
import 'package:app_well_mate/screen/drug/schedule_pages/drug_today.dart';
import 'package:flutter/material.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'medicationDetail.dart';

class MedicationPage extends StatefulWidget {
  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  final List<PrescriptionModel> prescriptions = PrescriptionModel.getData();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Lịch uống thuốc"),
          bottom: TabBar(dividerColor: AppColor.gray, tabs: const [
            Tab(
              text: "Thuốc chưa uống",
            ),
            Tab(
              text: "Thuốc đã uống",
            ),
            Tab(text: "Tất cả thuốc")
          ]),
        ),
        // floatingActionButton: const Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [MedicationFab()],
        // ),
        floatingActionButton: FabMenuButton(),
        body: const TabBarView(children: [
          DrugToday(),
          DrugDone(),
          AllDrug(),
        ]),
      ),
    );
  }
}
