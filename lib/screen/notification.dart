import 'dart:developer';

import 'package:app_well_mate/api/notification/notification_repo.dart';
import 'package:app_well_mate/components/notification_item.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/notification_model.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel>? notifications = [];
  List<NotificationModel> _listRed = [];
  List<NotificationModel> _listBlue = [];
  NotificationRepo repo = NotificationRepo();
  getData() async {
    notifications = await repo.getNotifications();
  }

  Future<void>? future;
  @override
  void initState() {
    super.initState();
    future = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
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
            _listRed = notifications!
                .where((e) =>
                    (e.priority! == '1' ||
                        e.priority! == '4' ||
                        e.priority! == '5') &&
                    checkExpire(e.time!))
                .toList();
            // sort
            _listRed.sort((a, b) => b.time!.compareTo(a.time!));

            _listBlue = notifications!
                .where((e) => (!_listRed.contains(e)) && checkExpire(e.time!))
                .toList();
            _listBlue.sort((a, b) => b.time!.compareTo(a.time!));
            return Container(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Quan trọng',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return NotifyComponent(
                          onDelete: (idNoti) {
                            notifications!.removeWhere((e) => e.id == idNoti);
                            setState(() {});
                          },
                          notifiItem: _listRed[index],
                          isImportant: true,
                        );
                      },
                      childCount: _listRed.length,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Divider(),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (_listBlue.isEmpty) {
                          return Text("Empty");
                        }
                        var now = DateTime.now();
                        now.difference(_listBlue[index].time!);
                        //var timeOfNotifi = now.difference(_listBlue[index].time!);

                        List<NotificationModel> arrRecently = [];
                        List<NotificationModel> arrYesterday = [];
                        List<NotificationModel> arrFurther = [];

                        for (var notification in _listBlue) {
                          var timeOfNotifi = now.difference(notification.time!);

                          if (timeOfNotifi.inMinutes < 60 ||
                              timeOfNotifi.inHours < 24) {
                            arrRecently.add(notification);
                          } else if (timeOfNotifi.inDays < 7) {
                            arrYesterday.add(notification);
                          } else {
                            arrFurther.add(notification);
                          }
                        }

                        List<Widget> children = [];

                        if (arrRecently.isNotEmpty) {
                          children.add(Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text('Gần đây',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ));
                          children.addAll(arrRecently.map((notification) {
                            return NotifyComponent(
                                onDelete: (idNoti) {
                                  notifications!
                                      .removeWhere((e) => e.id == idNoti);
                                  setState(() {});
                                },
                                notifiItem: notification,
                                isImportant: false);
                          }).toList());
                        }

                        if (arrYesterday.isNotEmpty) {
                          children.add(Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text('Hôm qua',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ));
                          children.addAll(arrYesterday.map((notification) {
                            return NotifyComponent(
                                onDelete: (idNoti) {
                                  notifications!
                                      .removeWhere((e) => e.id == idNoti);
                                  setState(() {});
                                },
                                notifiItem: notification,
                                isImportant: false);
                          }).toList());
                        }

                        if (arrFurther.isNotEmpty) {
                          children.add(Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text('Xa hơn',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ));
                          children.addAll(arrFurther.map((notification) {
                            return NotifyComponent(
                                onDelete: (idNoti) {
                                  notifications!
                                      .removeWhere((e) => e.id == idNoti);
                                  setState(() {});
                                },
                                notifiItem: notification,
                                isImportant: false);
                          }).toList());
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: children,
                        );
                      },
                      childCount: 1,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

bool checkExpire(DateTime time) {
  var now = DateTime.now();
  var difference = now.difference(time);

  return difference.inDays <= 100 ? true : false;
}
