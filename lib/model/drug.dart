//mock data
import 'package:flutter/material.dart';

class Drug {
  int idThuoc = -1;
  String? name;
  TimeOfDay? dueTime;
  int? prescriptionCount;
  String? unit;
  int? quantity;
  int? userQuantity;
  Drug({this.idThuoc = -1, this.name, this.dueTime, this.prescriptionCount = -1, this.unit = "viên", this.quantity = 0, this.userQuantity = 1});
  factory Drug.fromJson(Map<String, dynamic> json) => Drug(
    idThuoc: json["id_drug"] ?? 0,
    name: json["name"] ?? "",
    unit: json["unit"] ?? ""
  );
}