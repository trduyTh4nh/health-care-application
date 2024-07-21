import 'package:app_well_mate/api/application/application_repo.dart';
import 'package:app_well_mate/components/fab_menu_button.dart';
import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/screen/drug/schedule_pages/all_drug.dart';
import 'package:app_well_mate/screen/drug/schedule_pages/drug_done.dart';
import 'package:app_well_mate/screen/drug/schedule_pages/drug_today.dart';
import 'package:app_well_mate/screen/drug_cart.dart';
import 'package:app_well_mate/screen/medicine_purchase_history.dart';
import 'package:app_well_mate/screen/notification.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});
  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Lịch uống thuốc"),
          bottom: TabBar(
            dividerColor: AppColor.gray,
            tabs: const [
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
            IconButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartPage()));
            }, icon:
                Consumer<CartPageProvider>(builder: (context, value, child) {
              return Badge(
                label: Text(value.listDrugCart.length.toString()),
                child: const Icon(
                  Symbols.shopping_cart,
                  size: 24,
                ),
              );
            })),
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
        body: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (lst == null) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.wifi_off_outlined,
                        size: 34,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Lỗi hệ thống",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Text(
                        "Ứng dụng đang gặp lỗi, vui lòng kiểm tra kết nối internet của bạn và thử lại sau.",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              }
              selected ??= lst![0];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                                      Icon(Icons.receipt_long),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: Text(
                                              "Bác sĩ ${e.doctorName} ngày ${DateFormat("dd/MM/yyyy").format(e.createdDate!)}"))
                                    ],
                                  )))
                              .toList(),
                          onChanged: (v) {
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
                  Expanded(
                    child: TabBarView(children: [
                      DrugToday(
                        idPre: selected!.idPre ?? -1,
                      ),
                      DrugDone(),
                      AllDrug(
                        prescriptionId: selected!.idPre ?? -1,
                      ),
                    ]),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
