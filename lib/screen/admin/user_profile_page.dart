import 'package:app_well_mate/api/application/application_repo.dart';
import 'package:app_well_mate/components/item_prescription_of_infomation_user.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:app_well_mate/model/user.dart';
import 'package:app_well_mate/screen/search/component_crawl.dart';
import 'package:flutter/material.dart';

import 'package:material_symbols_icons/symbols.dart';

class UserProfilePage extends StatefulWidget {
  final User user;
  const UserProfilePage({super.key, required this.user});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  double calculateBMI(int weight, int heightInCm) {
    double heightInMeters = heightInCm / 100.0;
    // Tính BMI
    return weight / (heightInMeters * heightInMeters);
  }

  List<PrescriptionModel>? prescriptions;
  bool isLoadingPrescriptions = true;

  @override
  void initState() {
    loadPrescriptions();
    super.initState();
  }

  Future<void> loadPrescriptions() async {
    try {
      if (widget.user.idUser != null) {
        List<PrescriptionModel>? fetchedPrescriptions =
            await ApplicationRepo().getPrescriptionInUser(widget.user.idUser!);
        setState(() {
          prescriptions = fetchedPrescriptions;
        });
      } else {
        log('User ID is null');
      }
    } catch (e) {
      log('Error loading prescriptions: $e');
    } finally {
      setState(() {
        isLoadingPrescriptions = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int weight = (widget.user.profile?.weight ?? 0.0).toInt();
    int heightInCm = (widget.user.profile?.height ?? 0.0).toInt();

    double bmi = calculateBMI(weight, heightInCm);

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: colorScheme.surface,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff6a94ff),
              Colors.white,
            ],
          )),
          height: MediaQuery.of(context).size.height * 1 / 2,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: colorScheme.surface.withAlpha(100),
              title: const Text(
                "Thông tin người dùng",
              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Hero(
                      tag: "01",
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: widget.user.profile?.avatar != null
                            ? NetworkImage(widget.user.profile!.avatar!)
                            : const NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnSA1zygA3rubv-VK0DrVcQ02Po79kJhXo_A&s'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Hero(
                    tag: "02",
                    child: Text(
                      widget.user.userName ?? "User",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Divider(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 13, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.all(2)),
                        Text(
                          "Thông tin cơ bản",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            const Icon(Symbols.email),
                            const SizedBox(width: 10),
                            const Text("Email: "),
                            Text(widget.user.email ?? "Chưa có email"),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Symbols.monitor_weight),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("Cân nặng: "),
                                      Text(
                                          "${widget.user.profile!.weight ?? 0} kg"),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Symbols.height),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("Chiều cao: "),
                                      Text(
                                          "${widget.user.profile!.height ?? 0} cm"),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("BMI: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                  Text(bmi.toStringAsFixed(1),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall)
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              const Icon(Symbols.cake),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Tuổi "),
                              Text("${widget.user.profile?.age ?? 0} tuổi"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              const Icon(Symbols.wc),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Giới tính: "),
                              Text(
                                "${widget.user.profile!.gender?.trim() ?? 'N/A'}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Symbols.corporate_fare),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Địa chỉ:"),
                                Expanded(
                                  child:
                                      Text("${widget.user.profile!.address}"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "Đơn thuốc",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        isLoadingPrescriptions
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : prescriptions == null || prescriptions!.isEmpty
                                ? const Text("Không có đơn thuốc")
                                : ItemPrescriptionOfInfomationUser(
                                    prescriptions: prescriptions!,
                                  ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
