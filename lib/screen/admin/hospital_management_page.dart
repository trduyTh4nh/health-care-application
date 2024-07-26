import 'package:app_well_mate/api/hopital/hopital_repo.dart';
import 'package:app_well_mate/components/item_hospital.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/hospital_model.dart';
import 'package:app_well_mate/screen/admin/hospital_detail.dart';
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
    fetchHospitals();
  }

  Future<void> fetchHospitals() async {
    setState(() {
      isLoading = true;
    });

    try {
      listHos = await HospitalRepo().getAllHospitals();
      search = listHos;
    } catch (e) {
      debugPrint("Error fetching hospitals: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _runFilter(String query) {
    List<HospitalModel> results = [];
    if (query.isEmpty) {
      results = listHos;
    } else {
      results = listHos
          .where((hospital) =>
              hospital.name != null &&
              hospital.name!.toLowerCase().contains(query.toLowerCase()))
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
            onPressed: () {}, 
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.flickr(
                leftDotColor: colorScheme.primary,
                rightDotColor: colorScheme.error,
                size: 48,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: searchController,
                    onChanged: _runFilter,
                    decoration: InputDecoration(
                      labelText: "Tìm kiếm",
                      hintText: "Nhập tên chi nhánh",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _runFilter(searchController.text);
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      itemCount: search.length,
                      itemBuilder: (context, index) {
                        var itemHos = search[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HospitalDetail(
                                  hospital: itemHos,
                                ),
                              ),
                            );
                          },
                          child: ItemHospital(hospital: itemHos),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
