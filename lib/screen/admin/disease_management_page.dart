import 'package:app_well_mate/components/item_sick.dart';
import 'package:flutter/material.dart';

class DiseaseManagementAdminPage extends StatefulWidget {
  const DiseaseManagementAdminPage({super.key});

  @override
  State<DiseaseManagementAdminPage> createState() =>
      _DiseaseManagementAdminPageState();
}

class _DiseaseManagementAdminPageState extends State<DiseaseManagementAdminPage>
    with TickerProviderStateMixin {
  String dropdownValue = 'Quý 1';
  String dropdownValue01 = 'Sốt xuất huyết';

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

    const List<String> list = <String>['Quý 1', 'Quý 2', 'Quý 3', 'Quý 4'];
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                      Icon(Icons.calendar_today),
                      SizedBox(
                        width: 10,
                      ),
                      Text(value)
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!; // Cập nhật biến trạng thái
                  print(dropdownValue);
                });
              },
            ),
          ),
          SizedBox(
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
              Container(
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
          Container(
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: "Biểu đồ dịch tễ",
                ),
                Tab(
                  text: "Biểu đồ dịch tễ",
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: sizeWidht,
              height: 400,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue01, // Sử dụng biến trạng thái ở đây
                        items: list01
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Icon(Icons.coronavirus_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(value)
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue01 =
                                value!; // Cập nhật biến trạng thái
                            print(dropdownValue01);
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          width: sizeWidht,
                          height: sizeHeight * 0.35,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(hintText: "Tìm kiếm"),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ItemSick(sizeWidht: sizeWidht),
                        ItemSick(sizeWidht: sizeWidht),
                        ItemSick(sizeWidht: sizeWidht),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
