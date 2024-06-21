import 'package:app_well_mate/model/hospital_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
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



List<PrescriptionModel> generateSamplePrescriptions() {
  return [
    PrescriptionModel(
      idPre: 3001,
      idUser: 101,
      idHospital: 201,
      createdDate: DateTime.now(),
      doctorName: "Dr. John Doe",
      status: "active", 
      hospital: HospitalModel(
        idHospital: 201,
        name: "General Hospital",
        address: "123 Main St",
        phone: "123-456-7890",
      ),
      prescriptionDetails: [
        PrescriptionDetailModel(
          idPreDetail: 1001,
          idDrug: 102,
          idPre: 1,
          notes: "Sau bửa ăn",
          quantity: 30,
          quantityUsed: 1,
          timeToUse: "Sáng",
        ),
        PrescriptionDetailModel(
          idPreDetail: 1002,
          idDrug: 103,
          idPre: 1,
          notes: "Before bed",
          quantity: 60,
          quantityUsed: 2,
          timeToUse: "Tối",
        ),
        PrescriptionDetailModel(
          idPreDetail: 1003,
          idDrug: 104,
          idPre: 2,
          notes: "Sau bửa ăn",
          quantity: 90,
          quantityUsed: 3,
          timeToUse: "Chiều",
        ),
        PrescriptionDetailModel(
          idPreDetail: 1004,
          idDrug: 105,
          idPre: 2,
          notes: "After meals",
          quantity: 90,
          quantityUsed: 3,
          timeToUse: "Chiều",
        ),
      ],
    ),
    PrescriptionModel(
      idPre: 3002,
      idUser: 102,
      idHospital: 202,
      createdDate: DateTime.now().subtract(Duration(days: 1)),
      doctorName: "Dr. Jane Smith",
      status: "completed", 
      hospital: HospitalModel(
        idHospital: 202,
        name: "City Clinic",
        address: "456 Elm St",
        phone: "987-654-3210",
      ),
      prescriptionDetails: [
        PrescriptionDetailModel(
          idPreDetail: 1003,
          idDrug: 303,
          idPre: 2,
          notes: "After meals",
          quantity: 90,
          quantityUsed: 3,
          timeToUse: "Afternoon",
        ),
      ],
    ),
  ];
}


List<PrescriptionModel> generateSamplePrescriptions() {
  return [
    PrescriptionModel(
      idPre: 3001,
      idUser: 101,
      idHospital: 201,
      createdDate: DateTime.now(),
      doctorName: "Dr. John Doe",
      status: "active", 
      hospital: HospitalModel(
        idHospital: 201,
        name: "General Hospital",
        address: "123 Main St",
        phone: "123-456-7890",
      ),
      prescriptionDetails: [
        PrescriptionDetailModel(
          idPreDetail: 1001,
          idDrug: 102,
          idPre: 1,
          notes: "Sau bửa ăn",
          quantity: 30,
          quantityUsed: 1,
          timeToUse: "Sáng",
        ),
        PrescriptionDetailModel(
          idPreDetail: 1002,
          idDrug: 103,
          idPre: 1,
          notes: "Before bed",
          quantity: 60,
          quantityUsed: 2,
          timeToUse: "Tối",
        ),
        PrescriptionDetailModel(
          idPreDetail: 1003,
          idDrug: 104,
          idPre: 2,
          notes: "Sau bửa ăn",
          quantity: 90,
          quantityUsed: 3,
          timeToUse: "Chiều",
        ),
        PrescriptionDetailModel(
          idPreDetail: 1004,
          idDrug: 105,
          idPre: 2,
          notes: "After meals",
          quantity: 90,
          quantityUsed: 3,
          timeToUse: "Chiều",
        ),
      ],
    ),
    PrescriptionModel(
      idPre: 3002,
      idUser: 102,
      idHospital: 202,
      createdDate: DateTime.now().subtract(Duration(days: 1)),
      doctorName: "Dr. Jane Smith",
      status: "completed", 
      hospital: HospitalModel(
        idHospital: 202,
        name: "City Clinic",
        address: "456 Elm St",
        phone: "987-654-3210",
      ),
      prescriptionDetails: [
        PrescriptionDetailModel(
          idPreDetail: 1003,
          idDrug: 303,
          idPre: 2,
          notes: "After meals",
          quantity: 90,
          quantityUsed: 3,
          timeToUse: "Afternoon",
        ),
      ],
    ),
  ];
}