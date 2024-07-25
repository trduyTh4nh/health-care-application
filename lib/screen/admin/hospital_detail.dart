import 'package:app_well_mate/components/hero_widget.dart';
import 'package:app_well_mate/main.dart';
import 'package:app_well_mate/model/hospital_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

// ignore: must_be_immutable
class HospitalDetail extends StatelessWidget {
  final HospitalModel hospital;
  HospitalDetail({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(hospital.createdDate ?? DateTime.now());

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.white,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff6a94ff), Colors.white],
          )),
          height: MediaQuery.of(context).size.height * 1 / 2,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: colorScheme.surface.withAlpha(100),
            title: const Text("Thông tin bệnh viện"),
          ),
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  children: [
                    Hero(
                      tag: hospital.idHospital ?? '', // Add a fallback value
                      child: Container(
                        height: 183,
                        width: 183,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: (hospital.avatars != null && hospital.avatars!.isNotEmpty)
                              ? NetworkImage(hospital.avatars!)
                              : const AssetImage('assets/images/quang_avt.jpeg') as ImageProvider,
                        ),
                      ),
                    ),
                    HeroWidget(
                      tag: hospital.name ?? '',
                      child: Text(
                        hospital.name ?? 'N/A', 
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    HeroWidget(
                      tag: hospital.createdDate?.toString() ?? '', 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Ký hợp đồng ngày:"),
                          Text(formattedDate),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text("Mã KCB:"),
                    //     Text(hospital.idHospital?.toString() ?? 'N/A'), 
                    //   ],
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thông tin cơ bản",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Icon(Symbols.account_box),
                              SizedBox(
                                width: 10,
                              ),
                              Text("115 bệnh nhân"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              const Icon(Symbols.pill),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Đã mua "),
                              Text(" 115 ",
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const Text(" thuốc"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Symbols.corporate_fare),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Địa chỉ:"),
                              const Expanded(
                                child: Text(
                                  " 84 Thành Thái, Phường 10, Quận 10, TP. Hồ Chí Minh",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Icon(Symbols.emergency),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Liên hệ cấp cứu: 115 "),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
