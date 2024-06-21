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

static List<HospitalModel> getData() {
    return [
      HospitalModel(
        idHospital: 1,
        name: "Bệnh viện Đại Học Y Dược",
        address: "123 ABC Street",
        phone: "0123456789",
        createdDate: DateTime.now(),
        contactInformation: "rintuan@gmail.com",
      ),
      HospitalModel(
        idHospital: 2,
        name: "Bệnh viện Hùng Vương",
        address: "456 DEF Street",
        phone: "0987654321",
        createdDate: DateTime.now(),
        contactInformation: "rintuan@gmail.com",
      ),
      HospitalModel(
        idHospital: 3,
        name: "Bệnh viện Trung Tâm",
        address: "789 GHI Street",
        phone: "1234567890",
        createdDate: DateTime.now(),
        contactInformation: "rintuan@gmail.com",
      ),
    ];
  }
}
