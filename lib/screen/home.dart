import 'dart:math';

import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/components/shotcut.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug.dart';
import 'package:app_well_mate/screen/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Drug> mockData = List.generate(
      10,
      (e) => Drug(
          idThuoc: e,
          name: "Paracetamol",
          dueTime: TimeOfDay(
              hour: Random().nextInt(24), minute: Random().nextInt(60)),
          unit: "Viên",
          prescriptionCount: Random().nextInt(100),
          quantity: Random().nextInt(100),
          userQuantity: Random().nextInt(100)));
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Drug> expiredDrugs =
        mockData.where((e) => e.dueTime!.hour >= TimeOfDay.now().hour).toList();
    List<Drug> otherDrugs =
        mockData.where((e) => !expiredDrugs.contains(e)).toList();
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
                Text("Trí Quang", style: Theme.of(context).textTheme.bodyMedium)
              ],
            )
          ],
        ),
        actions: [
          //KHÔNG ĐƯỢC CONST!!!!!
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
      body: ListView.separated(
          padding: EdgeInsets.only(bottom: 20),
          separatorBuilder: (context, index) => const Divider(
                indent: 20,
                endIndent: 20,
              ),
          itemCount: mockData.length + 1,
          itemBuilder: (context, index) {
            bool isExpiredDrug = index - 1 < expiredDrugs.length;
            int realIndex =
                isExpiredDrug ? index - 1 : index - expiredDrugs.length - 1;
            Drug item = Drug();
            if (realIndex != -1) {
              item = isExpiredDrug
                  ? expiredDrugs[realIndex]
                  : otherDrugs[realIndex];
            }
            return index == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Tác vụ nhanh")),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Shortcut(
                              icon: Icons.monitor_weight_outlined,
                              text: "Tính BMI",
                            )),
                            Expanded(
                                child: Shortcut(
                              icon: Icons.leaderboard_outlined,
                              text: "Theo dõi",
                            )),
                            Expanded(
                                child: Shortcut(
                              icon: Icons.camera_alt_outlined,
                              text: "Quét mã QR",
                            )),
                            Expanded(
                                child: Shortcut(
                              icon: Symbols.pill,
                              text: "Xem toa thuốc",
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
                                    onPressed: () {},
                                    icon: const Icon(Icons.close))
                              ],
                            ),
                            Text(
                              "Mùa này là mùa cảm cúm",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                                "expiredDrug: ${expiredDrugs.length}, otherDrugs: ${otherDrugs.length}"),
                            const SizedBox(height: 10),
                            SvgPicture.asset(
                              "assets/images/undraw_medical_research_qg4d1.svg",
                              height: 200,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : MedicationItem(
                    drug: item,
                    index: realIndex,
                    titleText: realIndex == 0
                        ? index - 1 == realIndex
                            ? "Quá giờ uống thuốc"
                            : "Sắp tới"
                        : null,
                  );
          }),
    );
  }
}
