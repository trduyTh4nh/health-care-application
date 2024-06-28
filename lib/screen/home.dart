import 'dart:math';

import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/components/shotcut.dart';
import 'package:app_well_mate/const/functions.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/screen/notification.dart';
import 'package:app_well_mate/screen/quick_action/bmi_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:page_transition/page_transition.dart';
import 'package:app_well_mate/screen/drug_cart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                quantityUsed: Random().nextInt(100),
                amountPerConsumption: Random().nextInt(10),
                notes: "Trước khi ăn"),
          ));
  List<ScheduleDetailModel> expiredData = [];
  List<ScheduleDetailModel> upcomingData = [];
  @override
  void initState() {
    expiredData = mockData
        .where((e) => toSecond(e.timeOfUse!) < toSecond(TimeOfDay.now()))
        .toList();
    upcomingData = mockData
        .where((e) =>
            toSecond(TimeOfDay.now()) - toSecond(e.timeOfUse!) > -3600 &&
            toSecond(TimeOfDay.now()) - toSecond(e.timeOfUse!) < 0)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                  Text(
                    "Xin chào,",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text("Trí Quang",
                      style: Theme.of(context).textTheme.bodyMedium)
                ],
              )
            ],
          ),
          actions: [
            //KHÔNG ĐƯỢC CONST!!!!!
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage()));
                },
                icon: Icon(
                  Symbols.shopping_cart,
                  size: 24,
                )),
            IconButton(
                onPressed: () {},
                icon: Badge(
                    child: Icon(Symbols.deployed_code),
                    smallSize: 0 /*và 5*/,
                    largeSize: 0)),

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
        body: CustomScrollView(
          //các sliver được đối xử như các "màn hình ảo" riêng biệt, cho nên chúng độc lập với nhau về constrant, size...
          //vì thế các listview, gridview và widget cứng có thể tồn tại chung với nhau
          //mà k bị RenderBox has no size.
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Tác vụ nhanh")),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Shortcut(
                          icon: Icons.monitor_weight_outlined,
                          text: "Tính BMI",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BmiPage(),
                                ));
                          },
                        )),
                        Expanded(
                            child: Shortcut(
                          icon: Icons.leaderboard_outlined,
                          text: "Theo dõi",
                          onTap: () {},
                        )),
                        Expanded(
                            child: Shortcut(
                          icon: Icons.camera_alt_outlined,
                          text: "Quét mã QR",
                          onTap: () {},
                        )),
                        Expanded(
                            child: Shortcut(
                          icon: Symbols.pill,
                          text: "Xem toa thuốc",
                          onTap: () {},
                        )),
                      ],
                    ),
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline_outlined,
                              color: colorScheme.error,
                            ),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.close))
                          ],
                        ),
                        Text(
                          "Mùa này là mùa cảm cúm",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Text("Hãy giữ gìn sức khoẻ nhé!"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/prevent_gif.gif",
                              height: 280,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
            )
          ],
        ));
  }
}
