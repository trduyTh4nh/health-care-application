import 'package:json_annotation/json_annotation.dart';

part 'json/prescription_model.g.dart';

@JsonSerializable()
class PrescriptionModel {
  int? idPre;
  DateTime? createdDate;
  String? doctorName;
  String? status; // tình trạng này là gì quên r
  int? idUser; // khóa ngoại
  int? idHospital; // khóa ngoại

  PrescriptionModel(
      {this.idPre,
      this.idUser,
      this.idHospital,
      this.createdDate,
      this.doctorName,
      this.status});

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$PrescriptionModelToJson(this);
}
