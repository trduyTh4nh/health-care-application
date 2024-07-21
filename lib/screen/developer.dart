import 'dart:developer';

import 'package:app_well_mate/components/snack_bart.dart';
import 'package:app_well_mate/providers/notification_provider.dart';
import 'package:app_well_mate/screen/admin/admin_page.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DeveloperScreen extends StatefulWidget {
  const DeveloperScreen({super.key});

  @override
  State<DeveloperScreen> createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> {
  bool isSpecificTime = false;
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  List<PendingNotificationRequest> rqs = [];
  tz.TZDateTime nextInstanceOfTime() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    String hour = hourController.text == "" ? "0" : hourController.text;
    String minute = minuteController.text == "" ? "0" : minuteController.text;
    String second = secondController.text == "" ? "0" : secondController.text;
    return tz.TZDateTime(tz.local, now.year, now.month, now.day,
        int.parse(hour), int.parse(minute), int.parse(second));
  }
    removeWaitList() async {
      await plugin.cancelAll();
      await updateNotifRequests();
      setState(() {
        
      });
    }

  updateNotifRequests() async {
    rqs = await plugin.pendingNotificationRequests();
  }
  scheduleNotification(BuildContext context) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    String hour = hourController.text == "" ? "0" : hourController.text;
    String minute = minuteController.text == "" ? "0" : minuteController.text;
    String second = secondController.text == "" ? "0" : secondController.text;
    Duration duration = Duration(
        hours: int.parse(hour),
        minutes: int.parse(minute),
        seconds: int.parse(second));
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
    if (isSpecificTime) {
      await plugin.zonedSchedule(2, "Lên lịch thông báo", duration.toString(),
          nextInstanceOfTime(), notifDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time);
    } else {
      await plugin.zonedSchedule(1, "Lên lịch thông báo", duration.toString(),
          tz.TZDateTime.now(tz.local).add(duration), notifDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Đã lên lịch thông báo $duration")));
    }
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
            .requestNotificationsPermission() ??
        false;
    if (res && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đã cấp quyền thông báo")));
    }
    await updateNotifRequests();
    setState(() {});
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
  @override
  void initState() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FOR TESTING PURPOSES ONLY"),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, value, child) {
          return CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminPage()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.admin_panel_settings_outlined),
                          SizedBox(width: 16),
                          Text("Cấp quyền admin"),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      value.requestPermission(context);
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
                      showCustomSnackBar(context, "test");
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hiện snackbar"),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      value.removeWaitList();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Huỷ thông báo"),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      value.showNotification();
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
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Lên lịch thông báo"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Switch(
                            value: isSpecificTime,
                            onChanged: (v) {
                              if (v) {
                                tz.TZDateTime now = tz.TZDateTime.now(tz.local);
                                hourController.text = now.hour.toString();
                                minuteController.text = now.minute.toString();
                                secondController.text = now.second.toString();
                              }
                              setState(() {
                                isSpecificTime = v;
                              });
                            }),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Chọn giờ cụ thể")
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: hourController,
                      decoration: const InputDecoration(label: Text("Giờ")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: minuteController,
                      decoration: const InputDecoration(label: Text("Phút")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: secondController,
                      decoration: const InputDecoration(label: Text("Giây")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          scheduleNotification(context);
                        },
                        child: const Text("Lên lịch")),
                  )
                ],
              ),
            ),
            SliverList.separated(
                itemCount: value.rqs.length,
                itemBuilder: (c, i) =>
                    Text("${value.rqs[i].id} : ${value.rqs[i].title} : ${value.rqs[i].body}"),
                separatorBuilder: (c, i) => const Divider()),
            SliverToBoxAdapter(
              child: FilledButton(
                  onPressed: () async {
                    String token = await SecureStorage.getToken();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(token)));
                  },
                  child: const Text("Lấy JWT Token")),
            )
          ]);
        }
      ),
    );
  }
}
