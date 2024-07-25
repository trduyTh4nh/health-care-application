import 'dart:developer';

import 'package:app_well_mate/api/drug/drug_repo.dart';
import 'package:app_well_mate/api/notification/notification_repo.dart';
import 'package:app_well_mate/api/schedule/schedule_repo.dart';
import 'package:app_well_mate/components/custom_dialog.dart';
import 'package:app_well_mate/components/info_component.dart';
import 'package:app_well_mate/components/medication_item.dart';
import 'package:app_well_mate/components/snack_bart.dart';
import 'package:app_well_mate/components/time_item.dart';
import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/notification_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/providers/notification_provider.dart';
import 'package:app_well_mate/screen/drug/drug_item.dart';
import 'package:app_well_mate/screen/drug/func_drug/index.dart';
import 'package:app_well_mate/screen/drug/prescription_item.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

class DrugInfoPage extends StatefulWidget {
  const DrugInfoPage(
      {super.key,
      this.notifiItem,
      this.model,
      this.idScheSelected = 0,
      this.idPre = -1});
  final NotificationModel? notifiItem;
  final ScheduleDetailModel? model;
  final int idScheSelected;
  final int idPre;
  @override
  State<DrugInfoPage> createState() => _DrugInfoPageState();
}

class _DrugInfoPageState extends State<DrugInfoPage> {
  DrugRepo drugRepo = DrugRepo();
  TimePickerEntryMode entryMode = TimePickerEntryMode.dial;
  Orientation? orientation;
  TextDirection textDirection = TextDirection.ltr;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
  bool use24HourTime = false;
  TimeOfDay? selectTimePicker;

  List<ScheduleDetailModel> _timesMorning1 = [];
  List<ScheduleDetailModel> _timesAfternoon1 = [];
  List<ScheduleDetailModel> _timesNight1 = [];
  final ScrollController _controller = ScrollController();

  // danh sách đơn thuốc chi tiết
  List<PrescriptionDetailModel> prescriptionDetailModel =
      generateSamplePrescriptionDetails();

  DrugModel? drugModel;
  PrescriptionDetailModel? prescriptionDetail;
  List<ScheduleDetailModel>? listScheduleDetail = [];
  int idScheSelected = 0;
  ScheduleRepo repo = ScheduleRepo();
  Future<void>? future;
  getSchedules() async {
    if (widget.idPre != -1) {
      prescriptionDetail = await drugRepo.getDrugBy(widget.idPre);
    }
    listScheduleDetail =
        await repo.findAllSchedulesBy(prescriptionDetail!.idPreDetail ?? -1);
    if (prescriptionDetail!.quantityUsed == prescriptionDetail!.quantity) {
      idScheSelected = 0;
    } else {
      idScheSelected = widget.idScheSelected;
    }
    setState(() {});
    log(idScheSelected.toString());
    renderListSchedule();
  }

  deleteSchedule(int id, BuildContext context) async {
    String res = await repo.deleteScheduleBy(id);
    if (context.mounted) {
      if (res == "Delete successfully!") {
        showCustomSnackBar(context, "Xoá thành công");
      } else {
        showCustomSnackBar(context, "Xoá thất bại");
      }
    }
  }

  @override
  void initState() {
    if (widget.model != null) {
      prescriptionDetail = widget.model!.detail;
    }
    future = getSchedules();
    super.initState();
  }

  void renderListSchedule() {
    List<ScheduleDetailModel> times1 =
        listScheduleDetail!.map((element) => element).toList();
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
  }

  deleteDrug(BuildContext context) async {
    try {
      await drugRepo.deletePrescriptionDetail(prescriptionDetail!.idPreDetail!);
      if (context.mounted) {
        showCustomSnackBar(context, "Xoá thành công");
        Navigator.pop(context);
      }
    } catch (ex) {
      if (context.mounted) {
        showCustomSnackBar(context, "Lỗi khi xoá thuốc");
      }
    }
  }

  Future<void>? deleteFuture;
  // mặc dù truyền notification item nhưng mà
  // sau này sẽ lấy notification item có id của
  // chi tiết đơn thuốc từ chi tiết tìm ra thuốc xong lấy dữ liệu gắn vào đây
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {},
                  value: MedicationItemAction.buy,
                  child: const ListTile(
                    leading: Icon(Symbols.shopping_bag),
                    title: Text("Thêm thuốc vào giỏ hàng"),
                  ),
                ),
                PopupMenuItem(
                  onTap: () {},
                  value: MedicationItemAction.delete,
                  child: const ListTile(
                    leading: Icon(Symbols.delete),
                    title: Text("Xóa thuốc"),
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case MedicationItemAction.buy:
                    break;
                  case MedicationItemAction.delete:
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              icon: const Icon(Icons.warning_outlined),
                              title: const Text("Xoá thuốc này khỏi toa"),
                              content: const Text(
                                  "Bạn có muốn xoá thuốc này khỏi toa?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        deleteFuture = deleteDrug(context);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Có")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Không"))
                              ],
                            ));
                    break;
                  default:
                    break;
                }
              },
            )
          ],
        ),
        body: FutureBuilder(
            future: deleteFuture,
            builder: (context, snapshot) {
              return TweenAnimationBuilder(
                  tween: Tween<double>(
                      begin: 0,
                      end: snapshot.connectionState == ConnectionState.waiting
                          ? .3
                          : 1),
                  curve: Curves.easeInOutCubic,
                  duration: const Duration(milliseconds: 200),
                  builder: (context, val, child) {
                    return Opacity(
                      opacity: val,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 18),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: FutureBuilder(
                                    future: future,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: LoadingAnimationWidget.flickr(
                                            leftDotColor: colorScheme.primary,
                                            rightDotColor: colorScheme.error,
                                            size: 48,
                                          ),
                                        );
                                      }

                                      if (listScheduleDetail!.isEmpty) {
                                        return Center(
                                          child: ErrorInfo(
                                            title: "Thuốc không hợp lệ",
                                            subtitle:
                                                "Có thể hệ thống đã bị lỗi, vui lòng thử lại sau. ${widget.idPre}",
                                            icon: Symbols.pill_off,
                                          ),
                                        );
                                      }
                                      return CustomScrollView(
                                        controller: _controller,
                                        slivers: [
                                          SliverToBoxAdapter(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: AppColors
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          100))),
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
                                                  prescriptionDetail!
                                                          .drug!.name ??
                                                      "null",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(fontSize: 32),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(Symbols.pill),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'Số lượng: ${prescriptionDetail!.quantity! - prescriptionDetail!.quantityUsed!}/${prescriptionDetail!.quantity ?? "0"}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                            Symbols.alarm),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          '1 ngày ${prescriptionDetail!.amountPerConsumption} ${prescriptionDetail!.drug!.unit}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(Symbols
                                                            .local_dining_rounded),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          '${prescriptionDetail!.notes.toString()}',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
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
                                          if (prescriptionDetail!
                                                  .quantityUsed ==
                                              prescriptionDetail!.quantity)
                                            SliverFillRemaining(
                                              child: Center(
                                                child: ErrorInfo(
                                                  title: "Đã hết thuốc này",
                                                  subtitle:
                                                      "Bạn đã uống hết thuốc này. Vui lòng mua thêm",
                                                  icon: Symbols.pill_off,
                                                ),
                                              ),
                                            ),
                                          if (prescriptionDetail!
                                                  .quantityUsed !=
                                              prescriptionDetail!.quantity)
                                          SliverList.separated(
                                            itemCount: _timesMorning1.length,
                                            itemBuilder: (context, index) {
                                              return _timesMorning1.isNotEmpty
                                                  ? TimeItem(
                                                      deleteScheduleById: (id) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              CustomDialog(
                                                            icon: Icons
                                                                .warning_rounded,
                                                            title:
                                                                "Xoá lịch uống thuốc",
                                                            subtitle:
                                                                "Bạn có chắc là muốn xoá lịch uống thuốc này không?",
                                                            onPositive:
                                                                () async {
                                                              await deleteSchedule(
                                                                  id, context);
                                                              listScheduleDetail
                                                                  ?.removeWhere(
                                                                      (e) =>
                                                                          e.idScheduleDetail ==
                                                                          id);
                                                              renderListSchedule();
                                                              setState(() {});
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      scheDetail:
                                                          _timesMorning1[index],
                                                      onDataChanged: (index) {
                                                        setState(() {
                                                          idScheSelected =
                                                              index;
                                                        });
                                                      },
                                                      isSelected: idScheSelected ==
                                                          _timesMorning1[index]
                                                              .idScheduleDetail,
                                                      time:
                                                          _timesMorning1[index]
                                                              .timeOfUse!,
                                                      title: index == 0
                                                          ? Text(
                                                              'Sáng',
                                                              style: GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : null,
                                                      sIndex:
                                                          _timesMorning1[index]
                                                              .idScheduleDetail,
                                                    )
                                                  : null;
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              height: 10,
                                            ),
                                          ),
                                          if (prescriptionDetail!
                                                  .quantityUsed !=
                                              prescriptionDetail!.quantity)
                                          SliverList.separated(
                                            itemCount: _timesAfternoon1.length,
                                            itemBuilder: (context, index) {
                                              //print(_timesMorning1[index].idScheduleDetail == _timesMorning1[idScheSelected].idScheduleDetail);
                                              return _timesAfternoon1.isNotEmpty
                                                  ? TimeItem(
                                                      deleteScheduleById: (id) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              CustomDialog(
                                                            icon: Icons
                                                                .warning_rounded,
                                                            title:
                                                                "Xoá lịch uống thuốc",
                                                            subtitle:
                                                                "Bạn có chắc là muốn xoá lịch uống thuốc này không?",
                                                            onPositive:
                                                                () async {
                                                              await deleteSchedule(
                                                                  id, context);
                                                              listScheduleDetail
                                                                  ?.removeWhere(
                                                                      (e) =>
                                                                          e.idScheduleDetail ==
                                                                          id);
                                                              renderListSchedule();
                                                              setState(() {});
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      scheDetail:
                                                          _timesAfternoon1[
                                                              index],
                                                      onDataChanged: (id) {
                                                        setState(() {
                                                          idScheSelected = id;
                                                        });
                                                      },
                                                      isSelected: idScheSelected ==
                                                          _timesAfternoon1[
                                                                  index]
                                                              .idScheduleDetail,
                                                      time: _timesAfternoon1[
                                                              index]
                                                          .timeOfUse!,
                                                      title: index == 0
                                                          ? Text(
                                                              'Chiều',
                                                              style: GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : null,
                                                      sIndex: _timesAfternoon1[
                                                              index]
                                                          .idScheduleDetail,
                                                    )
                                                  : null;
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              height: 10,
                                            ),
                                          ),
                                          if (prescriptionDetail!
                                                  .quantityUsed !=
                                              prescriptionDetail!.quantity)
                                          SliverList.separated(
                                            itemCount: _timesNight1.length,
                                            itemBuilder: (context, index) {
                                              return _timesNight1.isNotEmpty
                                                  ? TimeItem(
                                                      deleteScheduleById: (id) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              CustomDialog(
                                                            icon: Icons
                                                                .warning_rounded,
                                                            title:
                                                                "Xoá lịch uống thuốc",
                                                            subtitle:
                                                                "Bạn có chắc là muốn xoá lịch uống thuốc này không?",
                                                            onPositive:
                                                                () async {
                                                              await deleteSchedule(
                                                                  id, context);
                                                              listScheduleDetail
                                                                  ?.removeWhere(
                                                                      (e) =>
                                                                          e.idScheduleDetail ==
                                                                          id);
                                                              renderListSchedule();
                                                              setState(() {});
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      scheDetail:
                                                          _timesNight1[index],
                                                      onDataChanged: (index) {
                                                        setState(() {
                                                          idScheSelected =
                                                              index;
                                                        });
                                                      },
                                                      isSelected: idScheSelected ==
                                                          _timesNight1[index]
                                                              .idScheduleDetail,
                                                      time: _timesNight1[index]
                                                          .timeOfUse!,
                                                      title: index == 0
                                                          ? Text(
                                                              'Tối',
                                                              style: GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : null,
                                                      sIndex:
                                                          _timesNight1[index]
                                                              .idScheduleDetail,
                                                    )
                                                  : null;
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              height: 10,
                                            ),
                                          ),
                                          const SliverToBoxAdapter(
                                            child: SizedBox(
                                              height: 8,
                                            ),
                                          ),
                                          const SliverToBoxAdapter(
                                            child: Divider(),
                                          ),
                                          if (prescriptionDetail!
                                                  .quantityUsed !=
                                              prescriptionDetail!.quantity)
                                          SliverToBoxAdapter(
                                            child: InkWell(
                                              onTap: () async {
                                                final TimeOfDay? time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                  initialEntryMode: entryMode,
                                                  orientation: orientation,
                                                  builder:
                                                      (BuildContext context,
                                                          Widget? child) {
                                                    return Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                              materialTapTargetSize:
                                                                  tapTargetSize),
                                                      child: Directionality(
                                                        textDirection:
                                                            textDirection,
                                                        child: MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      use24HourTime),
                                                          child: child!,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );

                                                if (time != null) {
                                                  ScheduleDetailModel? res =
                                                      await repo
                                                          .insertScheduleDetail({
                                                    "id_app_detail":
                                                        prescriptionDetail!
                                                                .idPreDetail ??
                                                            -1,
                                                    // ignore: prefer_null_aware_operators
                                                    "id_schedule":
                                                        widget.model == null
                                                            ? null
                                                            : widget.model!
                                                                .idSchedule,
                                                    "quantity_used":
                                                        prescriptionDetail!
                                                                .quantityUsed ??
                                                            -1,
                                                    "time_use":
                                                        "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00"
                                                  });
                                                  if (res != null &&
                                                      context.mounted) {
                                                    showCustomSnackBar(context,
                                                        "Thêm lịch thành công");
                                                    setState(() {
                                                      listScheduleDetail!
                                                          .add(res);
                                                    });
                                                  } else if (context.mounted) {
                                                    showCustomSnackBar(context,
                                                        "Thêm lịch không thành công");
                                                  }
                                                }

                                                // var newSche1 = listScheduleDetail!
                                                //     .firstWhere((e) => e.idSchedule == 9);
                                                renderListSchedule();
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                child: Row(
                                                  children: [
                                                    const Icon(Symbols.add),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'Thêm thời gian',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SliverToBoxAdapter(
                                            child: SizedBox(
                                              height: 8,
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
                                            child: SizedBox(
                                              height: 8,
                                            ),
                                          ),
                                          SliverList.separated(
                                            itemCount: 1,
                                            itemBuilder: (context, index) {
                                              return DrugItem(
                                                  drugModel: prescriptionDetail!
                                                      .drug!);
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              height: 6,
                                            ),
                                          ),
                                          const SliverToBoxAdapter(
                                            child: SizedBox(
                                              height: 8,
                                            ),
                                          ),
                                          const SliverToBoxAdapter(
                                            child: Divider(),
                                          ),
                                          const SliverToBoxAdapter(
                                            child: SizedBox(
                                              height: 8,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              )
                            ]),
                      ),
                    );
                  });
            }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10),
                  ),
                  label: const Text(
                    'Báo lại cho tôi sau 10 phút',
                  ),
                  icon: const Icon(
                    Symbols.snooze,
                    color: Colors.black,
                  ),
                  onPressed: listScheduleDetail!.isEmpty || idScheSelected == 0
                      ? null
                      : () async {
                          await Provider.of<NotificationProvider>(context,
                                  listen: false)
                              .snoozeNotification(
                                  listScheduleDetail!.firstWhere((e) =>
                                      e.idScheduleDetail == idScheSelected),
                                  drugModel ?? widget.model!.detail!.drug!,
                                  widget.idPre,
                                  delayDuration);
                          if (context.mounted) {
                            showCustomSnackBar(context,
                                "Hệ thống sẽ thông báo lại sau 10 phút về giờ uống thuốc của thuốc này.");
                          }
                        },
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
                  ),
                  icon: const Icon(
                    Symbols.check,
                  ),
                  onPressed: listScheduleDetail!.isEmpty || idScheSelected == 0
                      ? null
                      : () async {
                          // ngay chỗ này cần
                          showDialog(
                              context: context,
                              builder: (c) => Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          LoadingAnimationWidget.flickr(
                                            leftDotColor: colorScheme.primary,
                                            rightDotColor: colorScheme.error,
                                            size: 48,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Vui lòng chờ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          )
                                        ],
                                      ),
                                    ),
                                  ));

                          int index = listScheduleDetail!.indexWhere(
                              (e) => e.idScheduleDetail == idScheSelected);
                          int res =
                              await DrugRepo().updateSchedule(idScheSelected);
                          if (res == 1) {
                            int idUser = await SecureStorage.getUserId();
                            await NotificationRepo().insertNotification({
                              "content":
                                  "Bạn đã ghi nhận uống thuốc ${prescriptionDetail != null ? prescriptionDetail!.drug!.name : widget.model!.detail!.drug!.name}",
                              "time": DateTime.now().toString(),
                              "id_user": idUser,
                              "isconfirmed": false,
                              "id_invoice": null,
                              "priority": 3,
                              "id_schedule_detail": idScheSelected
                            });
                            setState(() {
                              listScheduleDetail![index].lastConfirmed =
                                  DateTime.now();
                              idScheSelected = 0;
                            });
                            if (context.mounted) {
                              showCustomSnackBar(
                                  context, "Đã ghi nhận uống thuốc này.");
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                          } else if (context.mounted) {
                            showCustomSnackBar(
                                context, "Lỗi khi cập nhật đơn thuốc");
                          }
                          renderListSchedule();
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

  int index =
      _listFetch.indexWhere((element) => element.idScheduleDetail == id);
  if (index != -1) {
    _listFetch[index] = updatedModel;
    // Notify listeners about the change (if applicable)
    // notifyListeners();
  } else {}
}

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
