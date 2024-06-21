import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
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

 static List<PrescriptionModel> getData() {
  
    return [
      PrescriptionModel(
        idPre: 1,
        idUser: 1,
        idHospital: 1,
        createdDate: DateTime.parse("2024-05-30 23:34:56"),
        doctorName: "Dr. Smith",
        status: "Completed",
      ),
      PrescriptionModel(
        idPre: 2,
        idUser: 1,
        idHospital: 2,
        createdDate: DateTime.parse("2024-06-17 15:45:30"),
        doctorName: "Dr. John",
        status: "Pending",
      ),
      PrescriptionModel(
        idPre: 3,
        idUser: 1,
        idHospital: 3,
        createdDate: DateTime.parse("2024-06-15 10:20:00"),
        doctorName: "Dr. Emily",
        status: "Completed",
      ),
    ];
  }

  String convertTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return "Vừa xong";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} phút trước";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} giờ trước";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} ngày trước";
    } else {
      return "${(difference.inDays / 7).floor()} tuần trước";
    }
  }
  
}
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");
  String string = dateFormat.format(DateTime.now());

