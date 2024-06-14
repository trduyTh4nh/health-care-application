import 'package:app_well_mate/components/custom_elevated_check_btn.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/notification_model.dart';
import 'package:app_well_mate/screen/drug_info.dart';
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
  @override
  Widget build(BuildContext context) {
    Color colorBox =
        widget.isImportant ? colorScheme.error : colorScheme.primary;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DrugInfoPage()));
      },
      child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: colorBox,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: checkPriorityForIcon(widget.notifiItem.priority!),
                    ),
                  ),
                  const SizedBox(width: 6,),
                  Column(
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
                      Container(
                        padding: const EdgeInsets.only(right: 8),
                        width: 220, // MÁ NÓ CỨNG NGẮT
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.notifiItem.content!,
                                style: Theme.of(context).textTheme.bodyLarge,
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.notifiItem.convertTime(widget.notifiItem.time!),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  widget.notifiItem.status!
                      ? const SizedBox()
                      : CustomElevatedBtnCheck(
                          onTap: () {},
                          child: const Icon(
                            Symbols.check,
                            color: Colors.white,
                          ))
                ],
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
  } else {
    return const Icon(
      Symbols.pill,
      color: Colors.white,
    );
  }
}
