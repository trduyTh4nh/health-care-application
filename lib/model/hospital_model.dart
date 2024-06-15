import 'package:json_annotation/json_annotation.dart';
part 'json/hospital_model.g.dart';
@JsonSerializable()
class HospitalModel {
  int? idHospital;
  String? name;
  String? address;
  String? phone;
  DateTime? createdDate;
  String? contactInformation;

  HospitalModel(
      {this.idHospital,
      this.name,
      this.address,
      this.phone,
      this.createdDate,
      this.contactInformation});
factory HospitalModel.fromJson(Map<String, dynamic> json) => _$HospitalModelFromJson(json);
  Map<String, dynamic> toJson() => _$HospitalModelToJson(this);
}
