import 'package:app_well_mate/components/fab_menu_button.dart';
import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/screen/drug/schedule_pages/all_drug.dart';
import 'package:app_well_mate/screen/drug/schedule_pages/drug_done.dart';
import 'package:app_well_mate/screen/drug/schedule_pages/drug_today.dart';
import 'package:app_well_mate/screen/drug_cart.dart';
import 'package:app_well_mate/screen/medicine_purchase_history.dart';
import 'package:app_well_mate/screen/notification.dart';
import 'package:flutter/material.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:material_symbols_icons/symbols.dart';


class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});
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
          ],
          
          ),
          actions: [
            //KHÔNG ĐƯỢC CONST!!!!!
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const CartPage()));
                },
                icon: const Icon(
                  Symbols.shopping_cart,
                  size: 24,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MedicinePurchaseHistory()));
                },
                icon: const Badge(
                  smallSize: 0 /*và 5*/,
                  largeSize: 0,
                  child: Icon(Symbols.deployed_code),
                )),

            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationPage()));
                },
                icon: const Icon(
                  Symbols.notifications,
                  size: 24,
                ))
          ],
        ),
        // floatingActionButton: const Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [MedicationFab()],
        // ),
        floatingActionButton: const FabMenuButton(),
        body: const TabBarView(children: [
          DrugToday(),
          DrugDone(),
          AllDrug(),
        ]),
      ),
    );
  }
}
