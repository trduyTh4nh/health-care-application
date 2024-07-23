import 'package:app_well_mate/api/application/application_repo.dart';
import 'package:app_well_mate/api/drug/drug_repo.dart';
import 'package:app_well_mate/components/custom_dialog.dart';
import 'package:app_well_mate/components/info_component.dart';
import 'package:app_well_mate/components/snack_bart.dart';
import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/providers/notification_provider.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class PrescriptionPreview extends StatefulWidget {
  const PrescriptionPreview({super.key, required this.idPre});
  final int idPre;
  @override
  State<PrescriptionPreview> createState() => _PrescriptionPreviewState();
}

class _PrescriptionPreviewState extends State<PrescriptionPreview> {
  String? svg;
  DrugRepo repo = DrugRepo();
  ApplicationRepo appRepo = ApplicationRepo();
  DrugRepo drugRepo = DrugRepo();
  Future<void>? future;
  List<ScheduleDetailModel>? data = [];
  Future<void>? addFuture;
  getData() async {
    data = await repo.getPreDetail(widget.idPre);
    setState(() {});
  }

  addToApplication(BuildContext context) async {
    int res = await appRepo.scanApplication(widget.idPre);
    List<ScheduleDetailModel>? lst = await drugRepo.getPreDetail(widget.idPre);
    if (context.mounted && lst != null) {
      if (context.mounted) {
        if (res == 1) {
          for (var element in lst) {
            Provider.of<NotificationProvider>(context, listen: false)
                .scheduleNotification(element, element.detail!.drug!,
                    element.detail!.idPreDetail ?? -1);
          }
          Navigator.pop(context);
          showCustomSnackBar(context, "Thêm đơn thuốc thành công!");
        }
      } else if (res == -1) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => CustomDialog(
                  icon: Symbols.person,
                  title: "Đơn thuốc này đã có người sở hữu.",
                  subtitle:
                      "Điều này có nghĩa là đã có người đã quét đơn thuốc này và thêm đơn này vào tài khoản của họ.",
                  onPositive: () async {
                    String result;
                    var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SimpleBarcodeScannerPage(),
                        ));
                    if (res is String && context.mounted) {
                      result = res;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrescriptionPreview(
                                  idPre: int.parse(result))));
                    }
                  },
                  positiveText: "Quét lại",
                  negativeText: "Không, cảm ơn",
                ));
      } else {
        showCustomSnackBar(context, "Lỗi khi thêm đơn thuốc. Mã lỗi $res");
      }
    }
  }

  @override
  void initState() {
    final barcode = Barcode.code128();
    svg = barcode.toSvg(widget.idPre.toString(), height: 64, width: 72);
    future = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xem trước đơn thuốc"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: FilledButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                              title: "Huỷ thêm đơn thuốc",
                              subtitle:
                                  "Bạn có muốn huỷ thêm đơn thuốc này không?",
                              onPositive: () {},
                              positiveText: "Không",
                              negativeText: "Có",
                              onNegative: () {
                                Navigator.pop(context);
                              },
                            ));
                  },
                  child: const Text("Huỷ")),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: data != null
                      ? () {
                          setState(() {
                            addFuture = addToApplication(context);
                          });
                        }
                      : null,
                  child: FutureBuilder(
                      future: addFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LoadingAnimationWidget.flickr(
                              leftDotColor: colorScheme.surface,
                              rightDotColor: colorScheme.error,
                              size: 16);
                        }
                        return const Text("Thêm");
                      })),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.flickr(
                    leftDotColor: colorScheme.primary,
                    rightDotColor: colorScheme.error,
                    size: 48),
              );
            }
            if (data!.isEmpty) {
              return const Center(
                child: ErrorInfo(
                  title: "Không có thuốc trong đơn này",
                  subtitle:
                      "Bác sĩ chưa thêm thuốc vào đơn này hoặc hệ thống của chúng tôi đang bị trục trặc, vui lòng thử lại sau.",
                  icon: Symbols.pill_off_rounded,
                ),
              );
            }
            if (data == null) {
              return const Center(
                child: ErrorInfo(
                  title: "Lỗi hệ thống",
                  subtitle:
                      "Chúng tôi đang đang gặp trục trặc, vui lòng thử lại sau.",
                  icon: Symbols.error,
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Đơn thuốc",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SvgPicture.string(svg ?? ""),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Table(
                            border: TableBorder.all(),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(),
                              1: FlexColumnWidth(),
                              2: FlexColumnWidth(),
                              3: FlexColumnWidth()
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: <TableRow>[
                              TableRow(
                                  decoration:
                                      BoxDecoration(color: AppColor.gray),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Tên thuốc",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Số lượng",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Đơn vị",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Ghi chú",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                  ]),
                              ...data!.map((e) => TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e.detail!.drug!.name ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e.detail!.quantity.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e.detail!.drug!.unit ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e.detail!.amountPerConsumption} ${e.detail!.drug!.unit} 1 ngày",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                  ]))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
