import 'dart:developer';

import 'package:app_well_mate/screen/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider extends ChangeNotifier {
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  requestPermission(BuildContext context) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    InitializationSettings settings =
        const InitializationSettings(android: initializationSettingsAndroid);
    plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (r) {
        switch (r.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const AdminPage()));
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
        .requestNotificationsPermission() ?? false;
    if(res && context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đã cấp quyền thông báo")));
    }
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
  }
}