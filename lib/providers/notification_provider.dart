import 'dart:developer';
import 'dart:io';
import 'package:android_intent_plus/android_intent.dart';
import 'package:app_settings/app_settings.dart';
import 'package:app_well_mate/components/info_component.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/screen/admin/admin_page.dart';
import 'package:app_well_mate/screen/drug/drug_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationProvider extends ChangeNotifier {
  List<PendingNotificationRequest> rqs = [];
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  removeWaitList() async {
    await plugin.cancelAll();
    await updateNotifRequests();
    notifyListeners();
  }

  NotificationProvider() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
  }
  updateNotifRequests() async {
    rqs = await plugin.pendingNotificationRequests();
  }

  tz.TZDateTime nextInstanceOfTime(TimeOfDay time) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    return tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute, 0);
  }

  scheduleNotification(ScheduleDetailModel model, DrugModel drug, int detailId) async {
    const AndroidNotificationDetails details =
        AndroidNotificationDetails("c1", "notif test",
            channelDescription: "channel notif chay suon",
            importance: Importance.high,
            priority: Priority.high,
            actions: [
              AndroidNotificationAction('xnut', 'Xác nhận'),
              AndroidNotificationAction('snooze', 'Nhắc tôi sau 10p')
            ],
            ticker: 'ticker');
    const NotificationDetails notifDetails =
        NotificationDetails(android: details);
    await plugin.zonedSchedule(
        payload: detailId.toString(),
        model.idScheduleDetail ?? -1,
        "Đã đến giờ uống thuốc ${drug.name}",
        "Ấn vào đây để xem thêm",
        nextInstanceOfTime(model.timeOfUse!),
        notifDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  requestPermission(BuildContext context) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('pill');
    InitializationSettings settings =
        const InitializationSettings(android: initializationSettingsAndroid);
    plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (r) {
        
        switch (r.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const DrugInfo()));
            break;
          default:
            plugin.cancel(r.id!);
            if (r.actionId == "xnut") {
              log("Xác nhận");
            } else {
              log("Khác");
            }
            break;
        }
      },
    );
    bool res = await plugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()!
            .requestNotificationsPermission() ??
        false;
    if (res && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đã cấp quyền thông báo")));
      await updateNotifRequests();
      notifyListeners();
      
    } else if (context.mounted) {
      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ErrorInfo(
                        title: "Cấp quyền thông báo",
                        subtitle:
                            "Hãy cấp quyền thông báo cho ứng dụng để có thể nhận được thông báo uống thuốc!",
                        icon: Symbols.notifications_active,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  AppSettings.openAppSettings(
                                      type: AppSettingsType.notification);
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text("Cấp quyền")),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Không, cảm ơn")),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
    }
    await updateNotifRequests();
  }

  showNotification() async {
    const AndroidNotificationDetails details =
        AndroidNotificationDetails("c1", "notif test",
            channelDescription: "channel notif chay suon",
            importance: Importance.high,
            priority: Priority.high,
            actions: [
              AndroidNotificationAction('xnut', 'Xác nhận'),
              AndroidNotificationAction('snooze', 'Nhắc tôi sau 10p')
            ],
            ticker: 'ticker');
    const NotificationDetails notifDetails =
        NotificationDetails(android: details);
    await plugin.show(0, "Đã đến giờ uống thuốc",
        "Đã đến giờ uống thuốc Paracetamol", notifDetails);
    await updateNotifRequests();
  }
}
