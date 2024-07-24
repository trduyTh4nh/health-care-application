import 'dart:developer';

import 'package:app_well_mate/components/custom_elevated_check_btn.dart';
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
      {super.key, required this.notifiItem, required this.isImportant});
  final NotificationModel notifiItem;
  final bool isImportant;

  @override
  State<NotifyComponent> createState() => _NotifyComponentState();
}

class _NotifyComponentState extends State<NotifyComponent> {
  Widget checkWidgetReturn(String cateWidget) {
    // ignore: unnecessary_null_comparison
    if (cateWidget != null) {
      if (cateWidget == '2' || cateWidget == 'confirm') {
        return OrderStatus(
          notifiItem: widget.notifiItem,
        );
      } else if (cateWidget == 'important') {
        return HospitalDetailPage(notifiItem: widget.notifiItem);
      } else {
        log(widget.notifiItem.idDonThuocCT.toString());
        return DrugInfoPage(idPre: widget.notifiItem.idDonThuocCT!, idScheSelected: widget.notifiItem.idScheduleDetail ?? 0,);
      }
    } else {
      return const ErrorPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color colorBox =
        widget.isImportant ? colorScheme.error : colorScheme.primary;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    checkWidgetReturn(widget.notifiItem.priority!)));
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child:
                            checkPriorityForIcon(widget.notifiItem.priority!),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
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
                            
                            style: Theme.of(context).textTheme.bodyLarge,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.notifiItem
                                .convertTime(widget.notifiItem.time!),
                            style: Theme.of(context).textTheme.bodySmall,
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
              PopupMenuButton(
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: NotificationItemAction.delete,
                    child: ListTile(
                      leading: Icon(Symbols.delete),
                      title: Text('Xóa'),
                    ),
                  ),
                  PopupMenuItem(
                    value: NotificationItemAction.hide,
                    child: ListTile(
                      leading: Icon(Symbols.hide),
                      title: Text('Ẩn'),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}

Widget checkPriorityForIcon(String priority) {
  if (priority == 'overdue' || priority == 'runoutof') {
    return const Icon(
      Symbols.pill_off,
      color: Colors.white,
    );
  } else if (priority == 'delivery') {
    return const Icon(
      Symbols.local_shipping,
      color: Colors.white,
    );
  } else if (priority == 'confirm') {
    return const Icon(
      Symbols.stethoscope_check,
      color: Colors.white,
    );
  } else if (priority == 'important') {
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
