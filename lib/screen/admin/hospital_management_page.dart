import 'package:app_well_mate/components/item_hospital.dart';
import 'package:app_well_mate/model/hospital.dart';
import 'package:flutter/material.dart';

class HospitalManagementAdminPage extends StatefulWidget {
  const HospitalManagementAdminPage({super.key});

  @override
  State<HospitalManagementAdminPage> createState() =>
      _HospitalManagementAdminPageState();
}

class _HospitalManagementAdminPageState
    extends State<HospitalManagementAdminPage> {
  final TextEditingController searchController = TextEditingController();
  void onPressed() {}
  //Day la cho lay data
  List<Hospital> listHos = Data().listHos;
  List<Hospital> search = [];
  @override
  void initState() {
    super.initState();
    search = listHos;
  }

  void _runFilter(String enterKey) {
    List<Hospital> results = [];
    if (enterKey.isEmpty) {
      results = listHos;
    } else {
      results = listHos
          .where(
              (hos) => hos.name.toLowerCase().contains(enterKey.toLowerCase()))
          .toList();
    }
    setState(() {
      search = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Quản lý chi nhánh"),
        actions: [
          IconButton(
              onPressed: onPressed, icon: const Icon(Icons.notifications_none))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  labelText: "Tìm kiếm",
                  hintText: "Nhập tên chi nhánh",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  )),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                itemCount: search.length,
                itemBuilder: (context, index) {
                  var itemHos = search[index];
                  return ItemHospital(hospital: itemHos);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Data {
  List<Hospital> listHos = [
    Hospital(
        idHospital: 201,
        name: "Bệnh viện Hồng Hưng",
        address: "82 CMT8 Tây Ninh",
        phone: "0874657889",
        createDate: DateTime.now(),
        contactInfomation: "ABCXYZ",
        imageHospital:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGDK5XJ6rvuEzPsr7WMx1wvHDeEVeXUnuXGw&s"),
    Hospital(
        idHospital: 202,
        name: "Bệnh viện Đại Học Y Dược",
        address: "19 Lũy Bán Bích",
        phone: "0874657889",
        createDate: DateTime.now(),
        contactInfomation: "ABCXYZ",
        imageHospital:
            "https://static.vecteezy.com/system/resources/thumbnails/004/493/181/small_2x/hospital-building-for-healthcare-background-illustration-with-ambulance-car-doctor-patient-nurses-and-medical-clinic-exterior-free-vector.jpg"),
    Hospital(
        idHospital: 203,
        name: "Bệnh viện 115",
        address: "82 Lũy Bán Bích",
        phone: "0874657889",
        createDate: DateTime.now(),
        contactInfomation: "ABCXYZ",
        imageHospital:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIqzPnxNt51e9nRPs97qAplWFBmFcNGvqZsg&s")
  ];
}
