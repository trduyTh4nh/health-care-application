import 'package:app_well_mate/model/hospital_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
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
  HospitalModel? hospital;
  List<PrescriptionDetailModel>? prescriptionDetails = [];
  PrescriptionModel(
      {this.idPre,
      this.idUser,
      this.idHospital,
      this.createdDate,
      this.doctorName,
      this.status,
      this.prescriptionDetails,
      this.hospital
      });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$PrescriptionModelToJson(this);
}
