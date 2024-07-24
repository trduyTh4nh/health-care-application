import 'package:app_well_mate/components/hero_widget.dart';
import 'package:app_well_mate/model/hospital_model.dart';
import 'package:app_well_mate/screen/admin/hospital_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum HospitalEditOption { delete, edit }

class ItemHospital extends StatelessWidget {
  final HospitalModel hospital;
  ItemHospital({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(hospital.createdDate ?? DateTime.now());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HospitalDetail(hospital: hospital),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: (hospital.avatars != null && hospital.avatars!.isNotEmpty)
                          ? NetworkImage(hospital.avatars!) 
                          : const AssetImage('assets/images/quang_avt.jpeg') as ImageProvider,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  hospital.name ?? 'N/A',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Ký hợp đồng ngày ",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                formattedDate,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          // const Row(
                          //   children: [
                          //     Text("#201"),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // PopupMenuButton(
            //   itemBuilder: (context) => const [
            //     PopupMenuItem(
            //       value: HospitalEditOption.edit,
            //       child: Text("Chỉnh sửa"),
            //     ),
            //     PopupMenuItem(
            //       value: HospitalEditOption.delete,
            //       child: Text("Xóa"),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
