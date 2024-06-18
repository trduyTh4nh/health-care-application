import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/providers/add_page_provider.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class AddDrugSchedulePage extends StatefulWidget {
  const AddDrugSchedulePage({super.key});

  @override
  State<AddDrugSchedulePage> createState() => _AddDrugSchedulePageState();
}

class _AddDrugSchedulePageState extends State<AddDrugSchedulePage> {
  bool isCustom = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AddPageProvider>(builder: (context, value, child) {
      value.setCycle();
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Center(
                    child: SvgPicture.asset(
                  'assets/images/undraw_calendar.svg',
                  height: 125,
                )),
                const SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Chu kỳ uống thuốc của bạn như sau",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall),
                  ),
                ),
                const SizedBox(height: 20),
                value.habit != 0
                    ? Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Bắt đầu từ")),
                          ),
                          Material(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              onTap: () async {
                                value.startDate = await showTimePicker(
                                      context: context,
                                      initialTime: value.startDate,
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    ) ??
                                    value.startDate;
                              },
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Icon(Symbols.alarm),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            "${value.startDate.hour.toString().padLeft(2, '0')}:${value.startDate.minute.toString().padLeft(2, '0')}"),
                                      ]),
                                      Icon(Icons.edit_outlined)
                                    ],
                                  )),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Giãn cách thời gian")),
                          ),
                          Material(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              onTap: () async {
                                value.sDate = await showTimePicker(
                                      context: context,
                                      initialTime: value.sDate,
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: true),
                                          child: child!,
                                        );
                                      },
                                    ) ??
                                    value.sDate;
                              },
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Icon(Symbols.alarm),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            "${value.sDate.hour.toString().padLeft(2, '0')}:${value.sDate.minute.toString().padLeft(2, '0')}"),
                                      ]),
                                      Icon(Icons.edit_outlined)
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                      alignment: Alignment.centerLeft, child: Text("Chu kỳ")),
                ),
              ],
            ),
          ),
          SliverList.separated(
            itemCount: value.scheduleDetailModel.length,
            itemBuilder: (context, index) => Material(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Dismissible(
                background: Material(color: colorScheme.error,
                  child: const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.delete_outline, color: AppColors.backgroundColor,)
                      ],
                    ),
                  ),
                ),
                secondaryBackground: Material(color: colorScheme.error,
                  child: const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.delete_outline, color: AppColors.backgroundColor,)
                      ],
                    ),
                  ),
                ),
                key: UniqueKey(),
                onDismissed: (direction) {
                  value.removeFromScheduleDetailModel(index);
                  setState(() {
                    
                  });
                  value.isValid = value.scheduleDetailModel.isNotEmpty;
                },
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                  onTap: () async {},
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Icon(Symbols.alarm),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                                "${value.scheduleDetailModel[index]!.time!.hour.toString().padLeft(2, '0')}:${value.scheduleDetailModel[index]!.time!.minute.toString().padLeft(2, '0')}"),
                          ]),
                          Icon(Icons.edit_outlined)
                        ],
                      )),
                ),
              ),
            ),
            separatorBuilder: (context, index) => Divider(
              indent: 20,
              endIndent: 20,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Divider(
                  indent: 20,
                  endIndent: 20,
                ),
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  onTap: () async {
                    TimeOfDay t = TimeOfDay.now();
                    t = await showTimePicker(
                          context: context,
                          initialTime: t,
                          builder: (context, child) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        ) ??
                        t;
                    value
                        .addToScheduleDetailModel(ScheduleDetailModel(time: t));
                    value.habit = 0;
                  },
                  child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Icon(Symbols.add),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("Thêm thời gian"),
                          ]),
                        ],
                      )),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
