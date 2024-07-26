import 'package:app_well_mate/api/disease/disease_admin_repo.dart';
import 'package:app_well_mate/components/bieudodichte.dart';
import 'package:app_well_mate/components/danhsachdichbenh.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/disease.dart';
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
  int patientCount = 29192;

  late final TabController _tabController;

  final Map<String, int> patientData = {
    'Năm nay': 29192,
    '2023': 25000,
    '2022': 63610,
    '2021': 32060,
  };

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
    void onPressed() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AppPage(),
          ));
    }

    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidth = MediaQuery.of(context).size.width;

    const List<String> list = <String>[
      'Năm nay',
      '2023',
      '2022',
      '2021',
    ];
    // ignore: unused_local_variable

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Quản lý dịch bệnh"),
        actions: [
          IconButton(
              onPressed: onPressed, icon: const Icon(Icons.change_circle))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                value: dropdownValue,
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
                    patientCount = patientData[dropdownValue]!;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 160,
                  width: sizeWidth * 2 / 5,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(3, 6),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Số người được chuẩn đoán",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "$patientCount",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: sizeWidth * 2 / 5,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(3, 6),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          "Dịch bệnh mắc nhiều nhất",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "Sốt Xuất Huyết",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.white),
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
            SizedBox(
              width: sizeWidth,
              height: sizeHeight * 0.5,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Bieudodichte(),
                  Danhsachdichbenh(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
