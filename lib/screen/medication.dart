import 'package:app_well_mate/api/application/application_repo.dart';
import 'package:app_well_mate/components/fab_menu_button.dart';
import 'package:app_well_mate/components/info_component.dart';
import 'package:app_well_mate/components/shotcut.dart';
import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/main.dart';
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
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});
  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage>
    with SingleTickerProviderStateMixin {
  List<PrescriptionModel>? lst = [];
  bool isError = false;
  PrescriptionModel? selected;
  ApplicationRepo repo = ApplicationRepo();
  getData() async {
    lst = await repo.getPrescription();
  }

  late TabController controller;
  Future<void>? future;
  @override
  void initState() {
    future = getData();
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Lịch uống thuốc"),
        bottom: TabBar(
          controller: controller,
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
                        builder: (context) => const MedicinePurchaseHistory()));
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
      floatingActionButton: FabMenuButton(
        afterFinishAddingItem: () {
          initState();
        },
      ),
      body: FutureBuilder(
          future: future,
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
            if (lst!.isEmpty) {
              return ErrorInfo(
                title: "Không có đơn thuốc",
                subtitle:
                    "Vui lòng thêm đơn thuốc và các thuốc bằng cách quét mã vạch",
                icon: Symbols.pill,
                action: Shortcut(
                  icon: Icons.camera_alt_outlined,
                  text: "Quét mã",
                  onTap: () {},
                ),
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
                                    const Icon(Icons.receipt_long),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                            "Bác sĩ ${e.doctorName} ngày ${DateFormat("dd/MM/yyyy").format(e.createdDate!)}"))
                                  ],
                                )))
                            .toList(),
                        onChanged: (PrescriptionModel? v) {
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
                  child: TabBarView(controller: controller, children: [
                    DrugToday(
                      idPre: selected!.idPre ?? -1,
                    ),
                    const DrugDone(),
                    AllDrug(
                      prescriptionId: selected!.idPre ?? -1,
                    ),
                  ]),
                ),
              ],
            );
          }),
    );
  }
}
