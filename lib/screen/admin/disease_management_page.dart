import 'package:app_well_mate/components/bieudodichte.dart';
import 'package:app_well_mate/components/danhsachdichbenh.dart';
import 'package:app_well_mate/components/item_sick.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DiseaseManagementAdminPage extends StatefulWidget {
  const DiseaseManagementAdminPage({super.key});

  @override
  State<DiseaseManagementAdminPage> createState() =>
      _DiseaseManagementAdminPageState();
}

class _DiseaseManagementAdminPageState extends State<DiseaseManagementAdminPage>
    with TickerProviderStateMixin {
  String dropdownValue = 'Năm nay';
  String dropdownValue01 = 'Sốt xuất huyết';
  List<Color> gradientColors = [
    Colors.blue,
    Colors.green,
  ];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onPressed() {}
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidht = MediaQuery.of(context).size.width;

    const List<String> list = <String>['Năm nay', '2023', '2022', '2021'];
    const List<String> list01 = <String>[
      'Sốt xuất huyết',
      'Cảm',
      'Ngứa',
      'Đậu Mùa'
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Quản lý dịch bệnh"),
        actions: [
          IconButton(
              onPressed: onPressed, icon: const Icon(Icons.notifications_none))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Text(
              "Hiển thị thống kê cho",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue, // Sử dụng biến trạng thái ở đây
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(value)
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                  print(dropdownValue);
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                height: 121,
                width: sizeWidht * 1 / 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Số người được chuẩn đoán",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        "29.192",
                        style: Theme.of(context).textTheme.headlineLarge,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 121,
                width: sizeWidht * 1 / 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        "Dịch bệnh mắc nhiều nhất",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        "Sốt Xuất Huyết ",
                        style: Theme.of(context).textTheme.headlineLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            tabs: const [
              Tab(
                text: "Biểu đồ dịch tễ",
              ),
              Tab(
                text: "Danh sách dịch bệnh",
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: sizeWidht,
              height: 400,
              child: TabBarView(
                controller: _tabController,
                children: const [
                   Bieudodichte(),
                   Danhsachdichbenh(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
