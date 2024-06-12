import 'package:app_well_mate/model/hospital.dart';
import 'package:flutter/material.dart';

class ItemHospital extends StatelessWidget {
  Hospital hospital;
  ItemHospital({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWidht = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    Container(
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hospital.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                          ),
                          Row(
                            children: [
                              Text(
                                "Ký hợp đồng ngày ",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                "10-02-2024",
                                style: Theme.of(context).textTheme.labelMedium,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Mã KCB: ",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                "Không có",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          Text("#201"),
                        ],
                      ),
                    )
                  ],
                ),
                Icon(Icons.more_horiz),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
