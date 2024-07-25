import 'package:app_well_mate/api/hopital/hopital_repo.dart';
import 'package:app_well_mate/components/item_hospital.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/hospital_model.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HospitalManagementAdminPage extends StatefulWidget {
  const HospitalManagementAdminPage({super.key});

  @override
  State<HospitalManagementAdminPage> createState() =>
      _HospitalManagementAdminPageState();
}

class _HospitalManagementAdminPageState
    extends State<HospitalManagementAdminPage> {
  final TextEditingController searchController = TextEditingController();
  bool isLoading = true;
  List<HospitalModel> listHos = [];
  List<HospitalModel> search = [];

  @override
  void initState() {
    super.initState();
    future = fetchHospitals();
  }

  Future<void> fetchHospitals() async {
    setState(() {
      isLoading = true;
    });

    try {
      listHos = await HospitalRepo().getAllHospitals();
      search = listHos;
    } catch (e) {
      // Xử lý lỗi nếu cần
      debugPrint("Error fetching hospitals: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _runFilter(String enterKey) {
    List<HospitalModel> results = [];
    if (enterKey.isEmpty) {
      results = listHos;
    } else {
      results = listHos
          .where(
              (hos) => hos.name!.toLowerCase().contains(enterKey.toLowerCase()))
          .toList();
    }
    setState(() {
      search = results;
    });
  }

  Future<void>? future;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Quản lý chi nhánh"),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_none)),
        ],
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
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                      labelText: "Tìm kiếm",
                      hintText: "Nhập tên chi nhánh",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListView.separated(
                            separatorBuilder:(context, index) {
                              return Divider();
                            },
                            itemCount: search.length,
                            itemBuilder: (context, index) {
                              var itemHos = listHos[index];
                              return ItemHospital(hospital: itemHos);
                            },
                          ),
                        ),
                      ),
              ],
            );
          }),
    );
  }
}


// class Data {
//   List<Hospital> listHos = [
//     Hospital(
//         idHospital: 201,
//         name: "Bệnh viện Hồng Hưng",
//         address: "82 CMT8 Tây Ninh",
//         phone: "0874657889",
//         createDate: DateTime.now(),
//         contactInfomation: "ABCXYZ",
//         imageHospital:
//             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGDK5XJ6rvuEzPsr7WMx1wvHDeEVeXUnuXGw&s"),
//     Hospital(
//         idHospital: 202,
//         name: "Bệnh viện Đại Học Y Dược",
//         address: "19 Lũy Bán Bích",
//         phone: "0874657889",
//         createDate: DateTime.now(),
//         contactInfomation: "ABCXYZ",
//         imageHospital:
//             "https://static.vecteezy.com/system/resources/thumbnails/004/493/181/small_2x/hospital-building-for-healthcare-background-illustration-with-ambulance-car-doctor-patient-nurses-and-medical-clinic-exterior-free-vector.jpg"),
//     Hospital(
//         idHospital: 203,
//         name: "Bệnh viện 115",
//         address: "82 Lũy Bán Bích",
//         phone: "0874657889",
//         createDate: DateTime.now(),
//         contactInfomation: "ABCXYZ",
//         imageHospital:
//             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIqzPnxNt51e9nRPs97qAplWFBmFcNGvqZsg&s")
//   ];
// }
