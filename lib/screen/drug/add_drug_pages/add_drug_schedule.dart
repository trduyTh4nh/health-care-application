import 'package:app_well_mate/providers/add_page_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer<AddPageProvider>(
        builder: (context, value, child) => CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Center(
                          child: SvgPicture.asset(
                        'assets/images/undraw_time_management.svg',
                        width: 185,
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
                            child: Text("Giản cách thời gian")),
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
                                        "${value.sDate.hour.toString().padLeft(2, '0')}:${value.sDate.minute.toString().padLeft(2, '0')}"),
                                  ]),
                                  Icon(Icons.edit_outlined)
                                ],
                              )),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Chu kỳ")),
                      ),
                    ],
                  ),
                ),
                SliverList.separated(
                  itemCount: value.scheduleDetailModel.length,
                  itemBuilder: (context, index) => Material(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      onTap: () async {
                        
                      },
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
                  separatorBuilder: (context, index) => Divider(
                    indent: 20,
                    endIndent: 20,
                  ),
                )
              ],
            ));
  }
}
