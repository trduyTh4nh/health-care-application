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
      this.hospital});

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$PrescriptionModelToJson(this);
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
          quantityUsed: 1.0,
          timeToUse: "Sáng",
        ),
        PrescriptionDetailModel(
          idPreDetail: 1002,
          idDrug: 103,
          idPre: 1,
          notes: "Before bed",
          quantity: 60,
          quantityUsed: 2.0,
          timeToUse: "Tối",
        ),
        PrescriptionDetailModel(
          idPreDetail: 1003,
          idDrug: 104,
          idPre: 2,
          notes: "Sau bửa ăn",
          quantity: 90,
          quantityUsed: 3.0,
          timeToUse: "Chiều",
        ),
        PrescriptionDetailModel(
          idPreDetail: 1004,
          idDrug: 105,
          idPre: 2,
          notes: "After meals",
          quantity: 90,
          quantityUsed: 3.0,
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
          quantityUsed: 3.0,
          timeToUse: "Afternoon",
        ),
      ],
    ),
  ];
}
