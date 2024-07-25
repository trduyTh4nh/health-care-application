import 'dart:developer';

import 'package:app_well_mate/api/notification/notification_repo.dart';
import 'package:app_well_mate/components/custom_dialog.dart';
import 'package:app_well_mate/components/custom_elevated_check_btn.dart';
import 'package:app_well_mate/components/snack_bart.dart';
import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/notification_model.dart';
import 'package:app_well_mate/screen/drug_info.dart';
import 'package:app_well_mate/screen/error_page.dart';
import 'package:app_well_mate/screen/hospital_detail.dart';
import 'package:app_well_mate/screen/order/order_status.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

enum NotificationItemAction { delete, hide }

class NotifyComponent extends StatefulWidget {
  const NotifyComponent(
      {super.key,
      required this.notifiItem,
      required this.isImportant,
      this.onDelete});
  final NotificationModel notifiItem;
  final bool isImportant;
  final void Function(int idNoti)? onDelete;
  @override
  State<NotifyComponent> createState() => _NotifyComponentState();
}

class _NotifyComponentState extends State<NotifyComponent> {
  Future<void>? deleteFuture;
  Widget checkWidgetReturn(String cateWidget) {
    // ignore: unnecessary_null_comparison
    if (cateWidget != null) {
      if (cateWidget == '2') {
        return OrderStatus(
          notifiItem: widget.notifiItem,
        );
      } else if (cateWidget == 'important') {
        return HospitalDetailPage(notifiItem: widget.notifiItem);
      } else {
        log(widget.notifiItem.idDonThuocCT.toString());
        return DrugInfoPage(
          idPre: widget.notifiItem.idDonThuocCT!,
          idScheSelected: widget.notifiItem.idScheduleDetail ?? 0,
        );
      }
    } else {
      return const ErrorPage();
    }
  }

  delete(BuildContext context) async {
    bool res =
        await NotificationRepo().deleteNotification(widget.notifiItem.id ?? -1);
    if (res) {
      if (context.mounted) {
        showCustomSnackBar(context, "Đã xoá sản phẩm");
      }
      if (widget.onDelete != null) {
        widget.onDelete!(widget.notifiItem.id ?? -1);
      }
    }
  }

  onDelete(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
            icon: Symbols.notifications_off,
            title: "Xoá thông báo",
            subtitle:
                "Bạn có muốn xoá thông báo này không? Việc này không thể hoàn tác.",
            onPositive: () {
              deleteFuture = delete(context);
              setState(() {
                
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    Color colorBox =
        widget.isImportant ? colorScheme.error : colorScheme.primary;
    return FutureBuilder(
        future: deleteFuture,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            colorBox = AppColor.darkerGray;
          }
          return AnimatedOpacity(
            opacity:
                snapshot.connectionState == ConnectionState.waiting ? .2 : 1,
            duration: const Duration(milliseconds: 200),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            checkWidgetReturn(widget.notifiItem.priority!)));
              },
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: colorBox,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: checkPriorityForIcon(
                                    widget.notifiItem.priority!),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.isImportant
                                      ? Text(
                                          'Quan trọng',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: colorScheme.error,
                                                  fontWeight: FontWeight.bold),
                                        )
                                      : const SizedBox(),
                                  Text(
                                    widget.notifiItem.content!,
                                    maxLines: 3,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    widget.notifiItem
                                        .convertTime(widget.notifiItem.time!),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            onDelete(context);
                          },
                          icon: const Icon(Symbols.delete))
                    ],
                  )),
            ),
          );
        });
  }
}

Widget checkPriorityForIcon(String priority) {
  if (priority == '1' || priority == '4') {
    return const Icon(
      Symbols.pill_off,
      color: Colors.white,
    );
  } else if (priority == '2') {
    return const Icon(
      Symbols.local_shipping,
      color: Colors.white,
    );
  } else if (priority == '3') {
    return const Icon(
      Symbols.stethoscope_check,
      color: Colors.white,
    );
  } else if (priority == '4') {
    return const Icon(
      Symbols.restart_alt,
      color: Colors.white,
    );
  } else {
    return const Icon(
      Symbols.pill,
      color: Colors.white,
    );
  }
}
