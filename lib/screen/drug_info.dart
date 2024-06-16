import 'dart:math';
import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/components/time_item.dart';
import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/notification_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/screen/drug/func_drug/index.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class DrugInfoPage extends StatefulWidget {
  const DrugInfoPage({super.key, this.notifiItem});
  final NotificationModel? notifiItem;

  @override
  State<DrugInfoPage> createState() => _DrugInfoPageState();
}

class _DrugInfoPageState extends State<DrugInfoPage> {
  // final List<TimeOfDay> _times = List.generate(
  //     Random().nextInt(10),
  //     (e) =>
  //         TimeOfDay(hour: Random().nextInt(24), minute: Random().nextInt(60)));

  // List<TimeOfDay> _timesMorning = [];
  // List<TimeOfDay> _timesAfternoon = [];
  // List<TimeOfDay> _timesNight = [];

  List<ScheduleDetailModel> _timesMorning1 = [];
  List<ScheduleDetailModel> _timesAfternoon1 = [];
  List<ScheduleDetailModel> _timesNight1 = [];
  final ScrollController _controller = ScrollController();

  // danh sách đơn thuốc chi tiết
  List<PrescriptionDetailModel> prescriptionDetailModel =
      generateSamplePrescriptionDetails();

  DrugModel? drugModel;
  PrescriptionDetailModel? prescriptionDetail;
  List<ScheduleDetailModel>? listScheduleDetail;
  double _opacity = 1.0;
  int idScheSelected = 0;
  @override
  void initState() {
    // idDonThuocCT(notification) => idPre chi tiết (Predetail modele) "lúc đang ở đây sẵn lấy thông tin thuốc"
    //  => vô model của schedule_detail lấy ra thông tin  lịch thuốc

    super.initState();
    setState(() {});

    prescriptionDetail = prescriptionDetailModel[0];
    // lấy ra 1 chi tiết đơn thuốc (1:1 thuốc để làm data mẫu)
    drugModel = prescriptionDetail!.idDrug != null
        ? findDrugByIdPrescriptionDetail(prescriptionDetail!.idDrug!)
        : null;
    //  get list schedule detail

    listScheduleDetail = prescriptionDetail!.idPreDetail != null
        ? findScheduleDetail(prescriptionDetail!.idPreDetail!)
        : null;
    // List<TimeOfDay> times =
    //     listScheduleDetail?.map((element) => element.timeOfUse!).toList() ?? [];

    // _timesMorning = times.where((e) => e.hour >= 0 && e.hour <= 12).toList();
    // _timesMorning.sort((a, b) => a.hour.compareTo(b.hour));
    // _timesAfternoon = times.where((e) => e.hour > 12 && e.hour <= 18).toList();
    // _timesAfternoon.sort((a, b) => a.hour.compareTo(b.hour));
    // _timesNight = times.where((e) => e.hour > 18 && e.hour <= 24).toList();
    // _timesNight.sort((a, b) => a.hour.compareTo(b.hour));

    List<ScheduleDetailModel> times1 =
        listScheduleDetail?.map((element) => element).toList() ?? [];

    _timesMorning1 = times1
        .where((e) => e.timeOfUse!.hour >= 0 && e.timeOfUse!.hour <= 12)
        .toList();
    _timesMorning1
        .sort((a, b) => a.timeOfUse!.hour.compareTo(b.timeOfUse!.hour));
    _timesAfternoon1 = times1
        .where((e) => e.timeOfUse!.hour > 12 && e.timeOfUse!.hour <= 18)
        .toList();
    _timesAfternoon1
        .sort((a, b) => a.timeOfUse!.hour.compareTo(b.timeOfUse!.hour));
    _timesNight1 = times1
        .where((e) => e.timeOfUse!.hour > 18 && e.timeOfUse!.hour <= 24)
        .toList();
    _timesNight1.sort((a, b) => a.timeOfUse!.hour.compareTo(b.timeOfUse!.hour));

    // handle controller
    _controller.addListener(() {
      _opacity = (_controller.offset / 150).clamp(0, 1);
      if (_opacity != 1) {
        setState(() {});
      }
    });
  }

  // mặc dù truyền notification item nhưng mà
  // sau này sẽ lấy notification item có id của
  // chi tiết đơn thuốc từ chi tiết tìm ra thuốc xong lấy dữ liệu gắn vào đây
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Opacity(
            opacity: _opacity,
            child: Text(drugModel!.name ?? "null"),
          ),
          actions: [
            PopupMenuButton(itemBuilder: (context) => const [
                PopupMenuItem(
                  value: MedicationItemAction.confirm,
                  child: ListTile(
                    leading: Icon(Symbols.check),
                    title: Text("Xác nhận"),
                  ),
                ),
                 PopupMenuItem(
                  value: MedicationItemAction.snooze,
                  child: ListTile(
                    leading: Icon(Symbols.snooze),
                    title: Text("Nhặc tôi sau 10p nữa"),
                  ),
                ),
                 PopupMenuItem(
                  value: MedicationItemAction.buy,
                  child: ListTile(
                    leading: Icon(Symbols.shopping_bag),
                    title: Text("Mua thuốc này"),
                  ),
                ),
                 PopupMenuItem(
                  value: MedicationItemAction.edit,
                  child: ListTile(
                    leading: Icon(Symbols.edit),
                    title: Text("Sửa thuốc này"),
                  ),
                ),
                 PopupMenuItem(
                  value: MedicationItemAction.delete,
                  child: ListTile(
                    leading: Icon(Symbols.delete),
                    title: Text("Xóa thuốc này"),
                  ),
                ),
            ])
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
              child: CustomScrollView(
                controller: _controller,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: const Padding(
                            padding: EdgeInsets.all(25),
                            child: Icon(
                              Symbols.pill,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                        Text(
                          drugModel!.name ?? "null",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 32),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Symbols.pill),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Số lượng: ${prescriptionDetail!.quantityUsed!.toInt()}/${prescriptionDetail!.quantity ?? "0"}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Icon(Symbols.alarm),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${prescriptionDetail!.amount}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Row(
                              children: [
                                const Icon(Symbols.local_dining_rounded),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${prescriptionDetail!.notes}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 16,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      'Lịch uống thuốc',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                  SliverList.separated(
                    itemCount: _timesMorning1.length,
                    itemBuilder: (context, index) {
                      return _timesMorning1.isNotEmpty
                          ? TimeItem(
                              scheDetail: _timesMorning1[index],
                              onDataChanged: (index) {
                                setState(() {
                                  idScheSelected = index;
                                });
                              },
                              isSelected: idScheSelected ==
                                  _timesMorning1[index].idScheduleDetail,
                              time: _timesMorning1[index].timeOfUse!,
                              title: index == 0
                                  ? Text(
                                      'Sáng',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold),
                                    )
                                  : null,
                              sIndex: _timesMorning1[index].idScheduleDetail,
                            )
                          : null;
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverList.separated(
                    itemCount: _timesAfternoon1.length,
                    itemBuilder: (context, index) {
                      //print(_timesMorning1[index].idScheduleDetail == _timesMorning1[idScheSelected].idScheduleDetail);
                      return _timesAfternoon1.isNotEmpty
                          ? TimeItem(
                              scheDetail: _timesAfternoon1[index],
                              onDataChanged: (id) {
                                setState(() {
                                  idScheSelected = id;
                                });
                              },
                              isSelected: idScheSelected ==
                                  _timesAfternoon1[index].idScheduleDetail,
                              time: _timesAfternoon1[index].timeOfUse!,
                              title: index == 0
                                  ? Text(
                                      'Chiều',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold),
                                    )
                                  : null,
                              sIndex: _timesAfternoon1[index].idScheduleDetail,
                            )
                          : null;
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                  ),
                  SliverList.separated(
                    itemCount: _timesNight1.length,
                    itemBuilder: (context, index) {
                      return _timesNight1.isNotEmpty
                          ? TimeItem(
                              scheDetail: _timesNight1[index],
                              onDataChanged: (index) {
                                setState(() {
                                  idScheSelected = index;
                                });
                              },
                              isSelected: idScheSelected ==
                                  _timesNight1[index].idScheduleDetail,
                              time: _timesNight1[index].timeOfUse!,
                              title: index == 0
                                  ? Text(
                                      'Tối',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold),
                                    )
                                  : null,
                              sIndex: _timesNight1[index].idScheduleDetail,
                            )
                          : null;
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Divider(),
                  ),
                  SliverToBoxAdapter(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            const Icon(Symbols.add),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Thêm thời gian',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      'Thông tin thuốc',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: const Divider(),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Text('Thuốc chi tiết $index');
                  }, childCount: 3)),
                  const SliverToBoxAdapter(
                    child: Divider(),
                  ),
                  SliverToBoxAdapter(
                    child: Text(
                      'Toa thuốc',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Text('Component toa thuốc'),
                  ),
                ],
              ),
            )
          ]),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 10),
                      backgroundColor: AppColor.smoker),
                  label: Text(
                    'Báo lại cho tôi sau 10 phút',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  icon: const Icon(
                    Symbols.snooze,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10),
                  ),
                  label: Text(
                    'Đánh dấu đã uống',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                  icon: const Icon(
                    Symbols.check,
                  ),
                  onPressed: () {
                    // ngay chỗ này cần 
                    List<ScheduleDetailModel> _listFetch =
                        generateSampleScheduleDetails();
                  },
                ),
              )
            ],
          ),
        ));
  }
}

void updateElement(int id, ScheduleDetailModel updatedModel) {
  List<ScheduleDetailModel> _listFetch = generateSampleScheduleDetails();

  int index = _listFetch.indexWhere((element) => element.idScheduleDetail == id);
  if (index != -1) {
    _listFetch[index] = updatedModel;
    // Notify listeners about the change (if applicable)
   // notifyListeners();
  } else {
    // Handle the case where the element with the ID is not found
    print("Element with ID $id not found in the list.");
  }
}
// Widget timeComponent(int hour, BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8),
//     child: Material(
//       color: AppColor.gray,
//       borderRadius: BorderRadius.all(Radius.circular(20)),
//       child: InkWell(
//         onTap: () {},
//         child: Padding(
//           padding: const EdgeInsets.only(left: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   const Icon(Symbols.alarm),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   Text(
//                     '$hour:00 $session',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                 ],
//               ),
//               IconButton(onPressed: () {}, icon: const Icon(Symbols.more_horiz))
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

Widget timerWidget() {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: const BoxDecoration(),
    child: InkWell(
      onTap: () {},
      child: const Row(
        children: [
          Icon(Symbols.alarm),
        ],
      ),
    ),
  );
}
