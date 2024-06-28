import 'package:app_well_mate/screen/drug/schedule_pages/all_drug.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrugManagePage extends StatelessWidget {
  const DrugManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tất cả thuốc")),
      body: const AllDrug(),
    );
  }
}