import 'dart:developer';

import 'package:app_well_mate/api/payment/payment_repo.dart';
import 'package:app_well_mate/components/custom_dialog.dart';
import 'package:app_well_mate/components/snack_bart.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/history_stransaction_model.dart';
import 'package:app_well_mate/model/invoice_detail_model.dart';
import 'package:app_well_mate/model/payment_model.dart';
import 'package:app_well_mate/screen/drug_cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_symbols_icons/symbols.dart';

enum MedicationItemAction { delete, edit, snooze, buy, confirm }

class WidgetPrescriptionstatusCancelMedicine extends StatefulWidget {
  const WidgetPrescriptionstatusCancelMedicine(
      {super.key, this.model, this.idInvoice});
  final HistoryStransactionModel? model;
  final int? idInvoice;
  @override
  State<WidgetPrescriptionstatusCancelMedicine> createState() =>
      _WidgetPrescriptionstatusCancelMedicine();
}

class _WidgetPrescriptionstatusCancelMedicine
    extends State<WidgetPrescriptionstatusCancelMedicine> {
  PaymentRepo repo = PaymentRepo();
  bool isChecked = false;
  HistoryStransactionModel? modelState;
  getData() async {
    log(widget.idInvoice.toString());
    HistoryStransactionModel tmp = await repo.getAllInvoiceDetailBy(
        widget.idInvoice ?? widget.model!.idInvoice ?? -1);
    log(tmp.listInvoiceDetail.toString());
    if (widget.idInvoice != null) {
      modelState = tmp;
    } else {
      modelState = widget.model!;
      modelState!.listInvoiceDetail = tmp.listInvoiceDetail;
    }
  }

  cancelInvoice() async {
    bool res = await repo.destroyInvoice(modelState!.idInvoice ?? -1);
    if (res) {
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) => CustomDialog(
                title: "Bạn đã huỷ đơn hàng ${modelState!.idPayPal}",
                subtitle: "Đơn hàng sẽ không được giao cho bạn khi bạn huỷ",
                onPositive: () {},
                onlyOption: true,
                positiveText: "Đã rõ",
              ));
      setState(() {
        modelState!.isDestroy = true;
      });
    } else {
      showCustomSnackBar(navigatorKey.currentContext!, "Huỷ không thành công.");
    }
  }

  Future<void>? futureCancel;
  Future<void>? futureInvoice;
  @override
  void initState() {
    futureInvoice = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tình trạng đơn thuốc"),
      ),
      body: FutureBuilder(
          future: futureInvoice,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.flickr(
                    leftDotColor: colorScheme.primary,
                    rightDotColor: colorScheme.error,
                    size: 48),
              );
            }
            final addressArray = modelState!.address!.address!.split(",");
            String addressString = "${addressArray[0]}, ${addressArray[1]}";
            String phoneNumberString = addressArray.last;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      modelState!.isDestroy!
                          ? const Icon(Symbols.close)
                          : modelState!.status!
                              ? const Icon(Symbols.check_circle)
                              : LoadingAnimationWidget.flickr(
                                  leftDotColor: colorScheme.primary,
                                  rightDotColor: colorScheme.error,
                                  size: 32,
                                ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            modelState!.isDestroy!
                                ? "Bạn đã huỷ đơn thuốc này"
                                : modelState!.status!
                                    ? "Đơn thuốc đã được giao đến bạn"
                                    : "Đơn thuốc đang được chuẩn bị bởi nhà thuốc",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 24),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      itemCount: modelState!.listInvoiceDetail!.length,
                      itemBuilder: (context, index) {
                        InvoiceDetailModel model =
                            modelState!.listInvoiceDetail![index];
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                                model.drug!.drugImage ?? ""),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(model.drug!.name ?? "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge),
                                                  Text(
                                                      "${NumberFormat("##,###.##").format(model.drug!.price)}đ / ${model.drug!.unit}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall),
                                                  Text(
                                                      "${model.quantity} ${model.drug!.unit}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall),
                                                  Text(
                                                      NumberFormat("##,###.##")
                                                          .format(
                                                              model.quantity! *
                                                                  model.drug!
                                                                      .price!),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 7,
                      offset: const Offset(0, -5),
                    )
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Địa chỉ giao hàng"),
                        Text(
                          addressString,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text("Số điện thoại"),
                        Text(
                          phoneNumberString,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "Tổng tiền",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          "${NumberFormat("##,###.##").format(modelState!.totalPrice)}đ",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: modelState!.status! ||
                                          modelState!.isDestroy!
                                      ? null
                                      : () async {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CustomDialog(
                                                      icon:
                                                          Symbols.receipt_long,
                                                      title:
                                                          "Huỷ đơn hàng này?",
                                                      subtitle:
                                                          "Sau khi bạn huỷ, đơn hàng này sẽ không được giao đến bạn nữa.",
                                                      onPositive: () {
                                                        setState(() {
                                                          futureCancel =
                                                              cancelInvoice();
                                                        });
                                                      }));
                                        },
                                  child: Text("Hủy đơn thuốc")),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}



// Expanded(
//                     child: ElevatedButton(
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 WidgetStateProperty.all(colorScheme.error)),
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => CartPage()));
//                         },
//                         child: Text("Hủy đơn thuốc- KHÔNG HOÀN TIỀN")),
//                   ),