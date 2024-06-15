import 'package:json_annotation/json_annotation.dart';

part 'json/schedule_detail_model.g.dart';

@JsonSerializable()
class ScheduleDetailModel {
  int? idScheduleDetail;
  int? idDrugCartDetail; // khóa ngoại
  int? quantityUsed;
  int? idSchedule; // khóa ngoại
  String? status;

  ScheduleDetailModel(
      {this.idScheduleDetail,
      this.idDrugCartDetail,
      this.idSchedule,
      this.quantityUsed,
      this.status});

  factory ScheduleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleDetailModelToJson(this);
}
