import 'package:app_well_mate/components/hero_widget.dart';
import 'package:app_well_mate/model/hospital.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HospitalDetail extends StatelessWidget {
  HospitalDetail({super.key, required this.hospital});
  Hospital hospital;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(hospital.createDate);

    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin bệnh viện"),
      ),
      body: Column(
        children: [
          Hero(
            tag: hospital.idHospital,
            child: Container(
              height: 183,
              width: 183,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(hospital.imageHospital),
              ),
            ),
          ),
          HeroWidget(
            tag: hospital.name,
            child: Text(
              hospital.name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          HeroWidget(
            tag: hospital.createDate.toString(),
            child: Row(
              children: [Text("Ký hợp đồng ngày:"), Text(formattedDate)],
            ),
          ),
          Row(
            children: [Text("Mã KCB:"), Text(hospital.idHospital.toString())],
          )
        ],
      ),
    );
  }
}
