import 'package:app_well_mate/components/drug_super_detail_item.dart';
import 'package:app_well_mate/model/notification_model.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:flutter/material.dart';

class DrugSuperDetail extends StatefulWidget {
  const DrugSuperDetail({super.key});

  @override
  State<DrugSuperDetail> createState() => _DrugSuperDetailState();
}

class _DrugSuperDetailState extends State<DrugSuperDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<NotificationModel> notifications = [];
  List<NotificationModel> _listRed = [];
  List<NotificationModel> _listBlue = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    if (listNotification != null) {
      notifications = listNotification;

      _listRed = notifications
          .where((e) =>
              (e.priority! == 'overdue' || e.priority! == 'runoutof') &&
              checkExpire(e.time!))
          .toList();
      // sort
      _listRed.sort((a, b) => b.time!.compareTo(a.time!));

      _listBlue = notifications
          .where((e) => (!_listRed.contains(e)) && checkExpire(e.time!))
          .toList();
      _listBlue.sort((a, b) => b.time!.compareTo(a.time!));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('03/02/2023 - Chi Tiết'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryColor,
          indicatorColor: AppColors.primaryColor,
          unselectedLabelColor: Colors.black,
          indicatorWeight: 2.0,
          tabs: const [
            Tab(text: 'Thuốc chưa uống'),
            Tab(text: 'Thuốc đã uống'),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'Quá hạn',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column();
                },
                childCount: _listRed.length,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var now = DateTime.now();
                  var difference = now.difference(_listBlue[index].time!);
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

                  return Column(
                    children: children,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  );
                },
                childCount: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}

bool checkExpire(DateTime time) {
  var now = DateTime.now();
  var difference = now.difference(time);

  return difference.inDays <= 100 ? true : false;
}
