import 'dart:math';
import 'dart:ui';

import 'package:app_well_mate/api/drug/drug_repo.dart';
import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/components/shotcut.dart';
import 'package:app_well_mate/components/snack_bart.dart';
import 'package:app_well_mate/const/functions.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/providers/cart_page_provider.dart';
import 'package:app_well_mate/screen/FFMI.dart';
import 'package:app_well_mate/screen/medicine_purchase_history.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/screen/notification.dart';
import 'package:app_well_mate/screen/quick_action/bmi_page.dart';
import 'package:app_well_mate/screen/revisit_page.dart';
import 'package:app_well_mate/screen/scan.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:app_well_mate/screen/drug_cart.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DrugRepo repo = DrugRepo();
  List<ScheduleDetailModel> data = [];
  List<ScheduleDetailModel> expiredData = [];
  List<ScheduleDetailModel> upcomingData = [];
  bool showBanner = true;
  final List<String> _banners = [
    "banner1.json",
    "banner2.json",
    "banner3.json",
    "dotorjson.json",
    "fight_the_virus.json"
  ];
  Future<void> getSchedule() async {
    data = await repo.getSchedule();
    data = data.where((e) => e.lastConfirmed != DateTime.now()).toList();
  }

  onDelete(int id, BuildContext context) {
    setState(() {
      data.removeWhere((e) => e.idPreDetail == id);
    });
    showCustomSnackBar(context, "Xoá thuốc thành công");
  }

  onUpdate(int id, BuildContext context) {
    setState(() {
      data.removeWhere((e) => e.idScheduleDetail == id);
    });
  }
  

  Future<void>? future;
  @override
  void initState() {
    future = getSchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff6a94ff), Colors.white],
          )),
          height: MediaQuery.of(context).size.height * 1 / 2,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: colorScheme.surface.withAlpha(100),
              //IMPORTANT: Tắt nút back cho appBar
              automaticallyImplyLeading: false,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images-ext-1.discordapp.net/external/GzOumY3Ty-mCaQNSxtMOVR5BPLNstdlilADmc80Wfm8/%3Fsize%3D4096/https/cdn.discordapp.com/avatars/515061888258670602/69eaf1984e071ba575fe531b70b200c3.png?format=webp&quality=lossless&width=452&height=452"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Xin chào,",
                          style: Theme.of(context).textTheme.titleLarge!),
                      Text("Trí Quang",
                          style: Theme.of(context).textTheme.bodyMedium!)
                    ],
                  )
                ],
              ),
              actions: [
                //KHÔNG ĐƯỢC CONST!!!!!
                Consumer<CartPageProvider>(builder: (context, value, child) {
                  return Badge(
                    label: Text(
                      "${value.listDrugCart.length}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartPage()));
                        },
                        icon: const Icon(
                          Symbols.shopping_cart,
                          size: 24,
                        )),
                  );
                }),

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
            //Nôm na là cách tối ưu nhất để nhét nhiều ListView chung với các View cứng khác.
            body: FutureBuilder(
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
                  expiredData = data
                      .where((e) =>
                          (toSecond(e.timeOfUse!) <
                              toSecond(TimeOfDay.now())) &&
                          e.status != "not_done")
                      .toList();
                  upcomingData = data
                      .where((e) =>
                          (toSecond(TimeOfDay.now()) - toSecond(e.timeOfUse!) >
                                  -3600 &&
                              toSecond(TimeOfDay.now()) -
                                      toSecond(e.timeOfUse!) <
                                  0) &&
                          e.status != "not_done")
                      .toList();
                  return CustomScrollView(
                    //các sliver được đối xử như các "màn hình ảo" riêng biệt, cho nên chúng độc lập với nhau về constrant, size...
                    //vì thế các listview, gridview và widget cứng có thể tồn tại chung với nhau
                    //mà k bị RenderBox has no size.
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Material(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                color: colorScheme.surface.withAlpha(150),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Shortcut(
                                            icon: Icons.monitor_weight_outlined,
                                            text: "Tính BMI",
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BmiPage(),
                                                  ));
                                            },
                                          )),
                                          Expanded(
                                              child: Shortcut(
                                            icon: Icons.fitness_center,
                                            text: "Tính FFMI",
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FFMIPage(),
                                                  ));
                                            },
                                          )),
                                          Expanded(
                                              child: Shortcut(
                                            icon: Icons.camera_alt_outlined,
                                            text: "Quét mã",
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ScanPage(
                                                      automaticallyImplyLeading:
                                                          true,
                                                    ),
                                                  ));
                                            },
                                          )),
                                          Expanded(
                                              child: Shortcut(
                                            icon: Symbols.alarm,
                                            text: "Tái khám",
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const RevisitPage()));
                                            },
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            showBanner
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.error_outline_outlined,
                                              color: colorScheme.error,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    showBanner = false;
                                                  });
                                                },
                                                icon: const Icon(Icons.close))
                                          ],
                                        ),
                                        Text(
                                          "Mùa này là mùa cảm cúm",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        const Text("Hãy giữ gìn sức khoẻ nhé!"),
                                        Lottie.asset(
                                          "assets/images/${_banners[Random().nextInt(_banners.length)]}",
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      SliverList.separated(
                        itemCount: data.isEmpty ? 1 : expiredData.length,
                        itemBuilder: (context, index) => data.isNotEmpty
                            ? MedicationItem(
                                onUpdate: (scheid) {
                                  onUpdate(scheid, context);
                                },
                                onDelete: (preDetailId) {
                                  onDelete(preDetailId, context);
                                },
                                prescription: expiredData[index],
                                titleText:
                                    index == 0 ? "Quá giờ uống thuốc" : null,
                              )
                            : Center(
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                      const Text(
                                        "Bạn đã hoàn thành đợt thuốc ngày hôm nay!",
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                        separatorBuilder: (context, index) => const SizedBox(),
                      ),
                      SliverList.separated(
                          itemCount: upcomingData.length,
                          itemBuilder: (context, index) => MedicationItem(
                                onUpdate: (scheid) {
                                  onUpdate(scheid, context);
                                },
                                onDelete: (preDetailId) {
                                  onDelete(preDetailId, context);
                                },
                                prescription: upcomingData[index],
                                titleText: index == 0 ? "Sắp tới" : null,
                              ),
                          separatorBuilder: (context, index) =>
                              const SizedBox())
                    ],
                  );
                })),
      ],
    );
  }
}
