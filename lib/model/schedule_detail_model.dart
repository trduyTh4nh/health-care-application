import 'package:app_well_mate/model/prescription_detail_model.dart';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json/schedule_detail_model.g.dart';

@JsonSerializable()
class ScheduleDetailModel {
  int? idScheduleDetail;

  int? idPreDetail; // khóa ngoại
  int? idSchedule; // khóa ngoại
  String? status;
  TimeOfDay? timeOfUse; // thời gian sử dụng ví dụ thuốc Hapacol dùng [2:00, 3:30, 10:20]
  PrescriptionDetailModel? detail;
  TimeOfDay? time;

  ScheduleDetailModel(
      {this.idScheduleDetail,
      this.idPreDetail,
      this.idSchedule,
      this.status,
      this.timeOfUse,
      this.detail,});

  factory ScheduleDetailModel.fromJson(Map<String, dynamic> json) {
      String timeOfUse = json["time_use"] ?? "00:00:00";
      List<String> convert = timeOfUse.split(":");
      TimeOfDay tod = TimeOfDay(hour: int.parse(convert[0]), minute: int.parse(convert[1]));
      return ScheduleDetailModel(
        idSchedule: json["id_schedule"] ?? 0,
        idPreDetail: json["id_app_detail"] ?? 0,
        idScheduleDetail: json["id_schedule_detail"] ?? 0,
        status: json["status"] ? "done" : "not_done",
        timeOfUse: tod,
      );
  }
  Map<String, dynamic> toJson() => _$ScheduleDetailModelToJson(this);
}

List<ScheduleDetailModel> generateSampleScheduleDetails() {
  return [
    ScheduleDetailModel(
      idScheduleDetail: 1,
      idPreDetail: 1001,
      idSchedule: 201,
      status: "Completed",
      timeOfUse: const TimeOfDay(hour: 8, minute: 30),
    ),
    ScheduleDetailModel(
      idScheduleDetail: 2,
      idPreDetail: 1001,
      idSchedule: 202,
      status: "Pending",
      timeOfUse: const TimeOfDay(hour: 12, minute: 30),
    ),
    ScheduleDetailModel(
      idScheduleDetail: 3,
      idPreDetail: 1001,
      idSchedule: 203,
      status: "Pending",
      timeOfUse: const TimeOfDay(hour: 18, minute: 0),
    ),
      ScheduleDetailModel(
      idScheduleDetail: 4,
      idPreDetail: 1001,
      idSchedule: 203,
      status: "Missed",
      timeOfUse: const TimeOfDay(hour: 10, minute: 10),
    ),
      ScheduleDetailModel(
      idScheduleDetail: 5,
      idPreDetail: 1001,
      idSchedule: 203,
      status: "Pending",
      timeOfUse: const TimeOfDay(hour: 14, minute: 0),
    ),
      ScheduleDetailModel(
      idScheduleDetail: 6,
      idPreDetail: 1001,
      idSchedule: 203,
      status: "Missed",
      timeOfUse: const TimeOfDay(hour: 19, minute: 40),
    ),
     ScheduleDetailModel(
      idScheduleDetail: 7,
      idPreDetail: 1001,
      idSchedule: 203,
      status: "Pending",
      timeOfUse: const TimeOfDay(hour: 20, minute: 50),
    ),

     ScheduleDetailModel(
      idScheduleDetail: 8,
      idPreDetail: 1001,
      idSchedule: 203,
      status: "Missed",
      timeOfUse: const TimeOfDay(hour: 22, minute: 30),
    ),
    // Add more sample data as needed
  ];
}
