import 'dart:math';

import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/components/time_item.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class DrugInfo extends StatefulWidget {
  const DrugInfo({super.key, this.drug});
  final Drug? drug;
  @override
  State<DrugInfo> createState() => _DrugInfoState();
}

class _DrugInfoState extends State<DrugInfo> {
  List<TimeOfDay> _times = List.generate(
      Random().nextInt(10),
      (e) =>
          TimeOfDay(hour: Random().nextInt(24), minute: Random().nextInt(60)));
  List<TimeOfDay> _timesMorning = [];
  List<TimeOfDay> _timesAfternoon = [];
  List<TimeOfDay> _timesNight = [];
  final ScrollController _controller = ScrollController();
  double _opacity = 0.0;

  @override
  void initState() {
    _timesMorning = _times.where((e) => e.hour >= 0 && e.hour <= 12).toList();
    _timesAfternoon =
        _times.where((e) => e.hour >= 12 && e.hour <= 18).toList();
    _timesNight = _times.where((e) => e.hour >= 18).toList();
    

    super.initState();
    _controller.addListener(() {
      _opacity = (_controller.offset / 150).clamp(0, 1);
      if (_opacity != 1) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Opacity(
            opacity: _opacity,
            child: Text(
              widget.drug!.name ?? "",
            )),
        actions: [
          PopupMenuButton(
            style: Theme.of(context).iconButtonTheme.style,
            itemBuilder: (context) => const [
              PopupMenuItem(
                  value: MedicationItemAction.confirm,
                  child: ListTile(
                      leading: Icon(Symbols.check),
                      title: Text("Xác nhận đã uống"))),
              PopupMenuItem(
                  value: MedicationItemAction.snooze,
                  child: ListTile(
                      leading: Icon(Symbols.snooze),
                      title: Text("Nhắc tôi sau 10p nữa"))),
              PopupMenuItem(
                  value: MedicationItemAction.buy,
                  child: ListTile(
                      leading: Icon(Symbols.shopping_bag),
                      title: Text("Mua thuốc này"))),
              PopupMenuItem(
                  value: MedicationItemAction.edit,
                  child: ListTile(
                      leading: Icon(Symbols.edit),
                      title: Text("Sửa thuốc này"))),
              PopupMenuItem(
                  value: MedicationItemAction.delete,
                  child: ListTile(
                      leading: Icon(Symbols.delete),
                      title: Text("Xoá thuốc này"))),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _controller,
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(150))),
                          child: Padding(
                            padding: const EdgeInsets.all(26),
                            child: Icon(
                              Symbols.pill,
                              color: colorScheme.surface,
                              size: 54,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.drug!.name ?? "",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Symbols.pill),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Số lượng: ${widget.drug!.userQuantity}/${widget.drug!.quantity}",
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(Symbols.alarm),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    "Ngày ${_times.length} liều")
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            //đừng có const :)
                            const Row(
                              children: [
                                Icon(Symbols.local_dining),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Trước khi ăn")
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Lịch uống thuốc",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontFamily:
                                  GoogleFonts.inter(fontWeight: FontWeight.bold)
                                      .fontFamily),
                    ),
                  ),
                ),
                SliverList.separated(
                    itemCount: _timesMorning.length,
                    itemBuilder: (c, i) {
                      int nextIndex = i == _timesMorning.length ? i : i+1;
                      // return TimeItem(

                      //   time: _timesMorning[i],
                      //   title: i == 0
                      //       ? Text(
                      //           "Sáng",
                      //           style: GoogleFonts.inter(
                      //               fontWeight: FontWeight.bold),
                      //         )
                      //       : null,
                      // );
                    },
                    separatorBuilder: (c, i) => const SizedBox(height: 10)),
                SliverList.separated(
                    itemCount: _timesAfternoon.length,
                    itemBuilder: (c, i) {
                      // return TimeItem(
                      //   time: _timesAfternoon[i],
                      //   title: i == 0
                      //       ? Text(
                      //           "Chiều",
                      //           style: GoogleFonts.inter(
                      //               fontWeight: FontWeight.bold),
                      //         )
                      //       : null,
                      // );
                    },
                    separatorBuilder: (c, i) => const SizedBox(height: 10)),
                SliverList.separated(
                    itemCount: _timesNight.length,
                    itemBuilder: (c, i) {
                      // return TimeItem(
                      //   time: _timesNight[i],
                      //   title: i == 0
                      //       ? Text(
                      //           "Tối",
                      //           style: GoogleFonts.inter(
                      //               fontWeight: FontWeight.bold),
                      //         )
                      //       : null,
                      // );
                    },
                    separatorBuilder: (c, i) => const SizedBox(height: 10))
              ],
            ),
          ),
          Material(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                      child: FilledButton(
                          style: FilledButton.styleFrom(
                            maximumSize: const Size(double.infinity, 200),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Icon(Symbols.snooze),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: Text("Báo lại cho tôi sau 10p"))
                            ],
                          ))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            maximumSize: const Size(double.infinity, 200),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Icon(Symbols.check),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: Text("Đánh dấu đã uống"))
                            ],
                          ))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
