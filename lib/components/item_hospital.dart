import 'package:app_well_mate/components/hero_widget.dart';
import 'package:app_well_mate/model/hospital.dart';
import 'package:app_well_mate/screen/admin/hospital_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemHospital extends StatelessWidget {
  Hospital hospital;
  ItemHospital({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(hospital.createDate);

    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidht = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HospitalDetail(hospital: hospital),
              ));
        },
        child: Container(
          height: sizeHeight * 0.15,
          width: sizeWidht,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Hero(
                        tag: hospital.idHospital,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(hospital.imageHospital),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeroWidget(
                              tag: hospital.name,
                              child: Text(
                                hospital.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                              ),
                            ),
                            HeroWidget(
                              tag: hospital.createDate.toString(),
                              child: Row(
                                children: [
                                  Text(
                                    "Ký hợp đồng ngày ",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(
                                    formattedDate,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Mã KCB: ",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(
                                  hospital.idHospital.toString(),
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                            Text("#201"),
                          ],
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
