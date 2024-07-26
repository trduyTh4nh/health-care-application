import 'dart:async';
import 'dart:developer';
import 'package:app_settings/app_settings.dart';
import 'package:app_well_mate/api/notification/notification_repo.dart';
import 'package:app_well_mate/components/info_component.dart';
import 'package:app_well_mate/components/item_hospital.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/screen/drug_info.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:notification_listener_service/notification_listener_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void tapNotificationBackground(NotificationResponse res) {
  print("notification ${res.id}, ${res.actionId}");
}

class NotificationProvider extends ChangeNotifier {
  List<PendingNotificationRequest> rqs = [];
  List<ActiveNotification> acts = [];

  StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  removeWaitList() async {
    await plugin.cancelAll();
    await updateNotifRequests();
    notifyListeners();
  }

  initStream() {
    selectNotificationStream.stream.listen((e) {
      log("Select action");
    });
  }

  updateActiveNotification() async {
    acts = await plugin.getActiveNotifications();
    notifyListeners();
  }

  initNotification(List<ScheduleDetailModel> lst) async {
    await updateNotifRequests();
    if (rqs.isEmpty) {
      for (var element in lst) {
        scheduleNotification(
            element, element.detail!.drug!, element.detail!.idPreDetail!);
      }
    }
  }

  NotificationProvider() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
  }
  updateNotifRequests() async {
    rqs = await plugin.pendingNotificationRequests();
    await updateActiveNotification();
    notifyListeners();
  }

  tz.TZDateTime nextInstanceOfTime(TimeOfDay time) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    return tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute, 0);
  }

  tz.TZDateTime nextInstanceOfTimeDelayed(Duration duration, TimeOfDay time) {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    tz.TZDateTime now = tz.TZDateTime.now(tz.local).add(duration);
    return tz.TZDateTime(
        tz.local, now.year, now.month, now.day, time.hour, time.minute, 0);
  }

  scheduleNotification(
      ScheduleDetailModel model, DrugModel drug, int detailId) async {
    const AndroidNotificationDetails details = AndroidNotificationDetails(
        "c1", "notif test",
        channelDescription: "channel notif chay suon",
        importance: Importance.high,
        priority: Priority.high,
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
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  initPlatformState() async {}
  void startListening() async {}
  snoozeNotification(ScheduleDetailModel model, DrugModel drug, int detailId,
      Duration duration) async {
    DateFormat format = DateFormat("yyyy-MM-dd");
    bool isConfirmed =
        format.format(model.lastConfirmed!) == format.format(DateTime.now());
    const AndroidNotificationDetails details = AndroidNotificationDetails(
        "c1", "notif test",
        channelDescription: "channel notif chay suon",
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notifDetails =
        NotificationDetails(android: details);
    await plugin.zonedSchedule(
      payload: detailId.toString(),
      -(model.idScheduleDetail ?? 1),
      "Đã đến giờ uống thuốc ${drug.name}",
      "Ấn vào đây để xem thêm",
      tz.TZDateTime.now(tz.local).add(duration),
      notifDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  requestPermission(BuildContext context) async {
    /// check if notification permession is enebaled
    final bool status = await NotificationListenerService.isPermissionGranted();
    if (!status) {
      bool s1 = await NotificationListenerService.requestPermission();
      if (!s1) {
        if (context.mounted) {
          await showDialog(
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
                                "Hãy cấp quyền theo dõi thông báo cho ứng dụng để có thể lưu các thông báo mà bạn đã lỡ!",
                            icon: Symbols.notifications_active,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      NotificationListenerService
                                          .requestPermission();
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
      }
    }
    NotificationListenerService.notificationsStream.listen((event) async {
      if (event.packageName == "com.example.app_well_mate" &&
          !(event.hasRemoved!)) {
        log("Current notification: $event");
        int idUser = await SecureStorage.getUserId();
        NotificationRepo().insertNotification({
          "content": event.title ?? "",
          "time": DateTime.now().toString(),
          "id_user": idUser,
          "isconfirmed": false,
          "id_invoice": null,
          "priority": 1,
          "id_schedule_detail": (event.id ?? 0).abs()
        });
        updateNotifRequests();
      }
    });

    /// stream the incoming notification events
    log("request notif");
    initStream();
    var darwinInitializationSettings = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {
        print("receive notif");
      },
    );
    DarwinInitializationSettings initializationSettingsDarwin =
        darwinInitializationSettings;
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('pill');
    InitializationSettings settings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    plugin.initialize(settings, onDidReceiveNotificationResponse: (r) {
      switch (r.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          log(r.payload ?? "null");
          navigatorKey.currentState!.push(MaterialPageRoute(
              builder: (c) => DrugInfoPage(
                    idPre: int.parse(r.payload ?? "-1"),
                    idScheSelected: (r.id ?? -1) < 0 ? -r.id! : r.id!,
                  )));
          break;
        case NotificationResponseType.selectedNotificationAction:
          selectNotificationStream.add(r.actionId);
          break;
      }
    }, onDidReceiveBackgroundNotificationResponse: tapNotificationBackground);
    bool res = await plugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()!
            .requestNotificationsPermission() ??
        false;
    if (res && context.mounted) {
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

  showNotificationWithContent(String title, String content, int idPreDetail) async {
    const AndroidNotificationDetails details = AndroidNotificationDetails(
        "c1", "notif test",
        channelDescription: "channel notif chay suon",
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notifDetails =
        NotificationDetails(android: details);
    await plugin.show(
      0,
      title,
      content,
      notifDetails,
      payload: idPreDetail.toString()
    );
    await updateNotifRequests();
  }

  showNotification() async {
    const AndroidNotificationDetails details = AndroidNotificationDetails(
        "c1", "notif test",
        channelDescription: "channel notif chay suon",
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notifDetails =
        NotificationDetails(android: details);
    await plugin.show(0, "Đã đến giờ uống thuốc",
        "Đã đến giờ uống thuốc Paracetamol", notifDetails,
        payload: "17");
    await updateNotifRequests();
  }
}
