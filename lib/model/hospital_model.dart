import 'package:json_annotation/json_annotation.dart';
part 'json/hospital_model.g.dart';

@JsonSerializable()
class HospitalModel {
  int? idHospital;
  String? name;
  String? address;
  String? phone;
  DateTime? createdDate;
  String? avatars;

  HospitalModel(
      {this.idHospital,
      this.name,
      this.address,
      this.phone,
      this.createdDate,
      this.avatars});
  factory HospitalModel.fromJson(Map<String, dynamic> json) =>
      _$HospitalModelFromJson(json);
  Map<String, dynamic> toJson() => _$HospitalModelToJson(this);
}
// static List<HospitalModel> getData() {
//     return [
//       HospitalModel(
//         idHospital: 1,
//         name: "Bệnh viện Đại Học Y Dược",
//         address: "123 ABC Street",
//         phone: "0123456789",
//         createdDate: DateTime.now(),
//         contactInformation: "rintuan@gmail.com",
//       ),
//       HospitalModel(
//         idHospital: 2,
//         name: "Bệnh viện Hùng Vương",
//         address: "456 DEF Street",
//         phone: "0987654321",
//         createdDate: DateTime.now(),
//         contactInformation: "rintuan@gmail.com",
//       ),
//       HospitalModel(
//         idHospital: 3,
//         name: "Bệnh viện Trung Tâm",
//         address: "789 GHI Street",
//         phone: "1234567890",
//         createdDate: DateTime.now(),
//         contactInformation: "rintuan@gmail.com",
//       ),
//     ];
//   }

  



// List<HospitalModel> generateSampleHospital() {
//     return [
//       HospitalModel(
//         idHospital: 100,
//         name: "Phòng khám đa khoa bệnh viện Đại Học Y Dược",
//         address: "413, Điện Biên Phủ, Phường 10, Quận 3",
//         phone: "0988362384",
//         createdDate: DateTime.now(),
//         contactInformation: "bsdhyd@gmail.com",
//       ),
//       HospitalModel(
//         idHospital: 101,
//         name: "Phòng khám Tháng Tám",
//         address: "202, Cách mạng tháng 8, Phường 12, Quận 3",
//         phone: "0957348",
//         createdDate: DateTime.now(),
//         contactInformation: "pkthangt8@gmail.com",
//       ),
//       HospitalModel(
//         idHospital: 102,
//         name: "Phòng khám Hoàn Mỹ",
//         address: "60-62 Nguyễn Trãi, Phường Bến Thành, Quận 1",
//         phone: "0909876543",
//         createdDate: DateTime.now(),
//         contactInformation: "hoanmyclinic@gmail.com",
//       ),
//       HospitalModel(
//         idHospital: 103,
//         name: "Phòng khám Sài Gòn",
//         address: "125 Lê Lợi, Phường Bến Thành, Quận 1",
//         phone: "0988765432",
//         createdDate: DateTime.now(),
//         contactInformation: "saigonclinic@gmail.com",
//       ),
//       HospitalModel(
//         idHospital: 104,
//         name: "Phòng khám Bình Dân",
//         address: "371 Điện Biên Phủ, Phường 4, Quận 3",
//         phone: "0932765432",
//         createdDate: DateTime.now(),
//         contactInformation: "binhdanclinic@gmail.com",
//       ),
//       HospitalModel(
//         idHospital: 105,
//         name: "Phòng khám Quốc tế Hạnh Phúc",
//         address: "97 Nguyễn Thị Minh Khai, Phường Bến Thành, Quận 1",
//         phone: "0923654321",
//         createdDate: DateTime.now(),
//         contactInformation: "hanhphucclinic@gmail.com",
//       ),
//       HospitalModel(
//         idHospital: 106,
//         name: "Phòng khám Vinmec",
//         address: "208 Nguyễn Hữu Cảnh, Phường 22, Quận Bình Thạnh",
//         phone: "0912543210",
//         createdDate: DateTime.now(),
//         contactInformation: "vinmecclinic@gmail.com",
//       ),
//       HospitalModel(
//         idHospital: 107,
//         name: "Phòng khám Gia Đình",
//         address: "35 Nguyễn Văn Cừ, Phường Cầu Kho, Quận 1",
//         phone: "0932145678",
//         createdDate: DateTime.now(),
//         contactInformation: "giadinhclinic@gmail.com",
//       ),
//       HospitalModel(
//         idHospital: 108,
//         name: "Phòng khám Quốc tế Columbia Asia",
//         address: "8 Alexandre De Rhodes, Phường Bến Nghé, Quận 1",
//         phone: "0921345678",
//         createdDate: DateTime.now(),
//         contactInformation: "columbiaasiaclinic@gmail.com",
//       ),
//       HospitalModel(
//         idHospital: 109,
//         name: "Phòng khám Pasteur",
//         address: "152 Pasteur, Phường Bến Nghé, Quận 1",
//         phone: "0912345678",
//         createdDate: DateTime.now(),
//         contactInformation: "pasteurclinic@gmail.com",
//       ),
//     ];
//   }