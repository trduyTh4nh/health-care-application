import 'package:json_annotation/json_annotation.dart';

part 'json/schedule_model.g.dart';
@JsonSerializable()
class ScheduleModel {
  int? idSchedule;
  int? idDonThuoc; // khóa ngoại
  int? idUser; // khóa ngoại
  String? status; // trạng thái của lịch: đã uống xong, đang uống, sắp tới

  ScheduleModel({this.idDonThuoc, this.status, this.idSchedule, this.idUser});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => _$ScheduleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleModelToJson(this);
}
