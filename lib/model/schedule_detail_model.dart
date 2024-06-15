import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json/schedule_detail_model.g.dart';

@JsonSerializable()
class ScheduleDetailModel {
  int? idScheduleDetail;
  int? idPrescriptionDetail; // khóa ngoại
  int? quantityUsed;
  int? idSchedule; // khóa ngoại
  String? status;
  TimeOfDay? time;
  PrescriptionDetailModel? detail;
  ScheduleDetailModel(
      {this.idScheduleDetail,
      this.idPrescriptionDetail,
      this.idSchedule,
      this.quantityUsed,
      this.status,
      this.time,
      this.detail});

  factory ScheduleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleDetailModelToJson(this);
}
