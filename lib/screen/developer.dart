import 'dart:developer';

import 'package:app_well_mate/screen/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DeveloperScreen extends StatefulWidget {
  const DeveloperScreen({super.key});

  @override
  State<DeveloperScreen> createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> {
  static void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
    
  }
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  requestPermission(BuildContext context) {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    final InitializationSettings settings =
        InitializationSettings(android: initializationSettingsAndroid);
    plugin.initialize(settings, onDidReceiveNotificationResponse: (r) {
      switch(r.notificationResponseType){
        case NotificationResponseType.selectedNotification:
          Navigator.push(context, MaterialPageRoute(builder: (c) => AdminPage()));
          log("Ấn vào noti");
          break;
        default:
          plugin.cancel(r.id!);
          if(r.actionId == "xnut"){
            log("Xác nhận");
          } else {
            log("Khác");
          }
          break;
      }
    },);
    plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
  }

  showNotification() async {
    const AndroidNotificationDetails details = AndroidNotificationDetails(
        "c1", "notif test",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FOR TESTING PURPOSES ONLY"),
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AdminPage()));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.admin_panel_settings_outlined),
                    const SizedBox(width: 16),
                    const Text("Chuyển sang trang Admin"),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                requestPermission(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.notification_add_outlined),
                    SizedBox(width: 16),
                    Text("Cấp quyền thông báo"),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showNotification();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.notifications_active_outlined),
                    SizedBox(width: 16),
                    Text("Hiện thông báo"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
