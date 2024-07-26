import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/hospital_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart'; // Import PrescriptionDetailModel
import 'package:json_annotation/json_annotation.dart';

part 'json/prescription_model.g.dart';

@JsonSerializable()
class PrescriptionModel {
  int? idPre;
  DateTime? createdDate;
  DateTime? revisitDate; //ngày tái khám
  String? roomRevisit; // phòng tái khám
  String? doctorName;
  String? status;
  int? idUser;
  int? idHospital;
  HospitalModel? hospital;
  String? nameDisease;
  List<PrescriptionDetailModel>?
      prescriptionDetails; // List of PrescriptionDetailModel

  PrescriptionModel(
      {this.idPre,
      this.idUser,
      this.idHospital,
      this.createdDate,
      this.doctorName,
      this.status,
      this.prescriptionDetails,
      this.revisitDate,
      this.hospital,
      this.roomRevisit,
      this.nameDisease});

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      idPre: json["id"] ?? -1,
      createdDate: DateTime.parse(json["created_date"]),
      doctorName: json["doctor_name"],
      status: json["status"],
      idUser: json["id_user"] ?? -1,
      idHospital: json["id_hospital"] ?? -1,
      hospital: HospitalModel.fromJson(json["hospital"]),
      nameDisease: json["disease"]["disease_name"]
    );
  }
  Map<String, dynamic> toJson() => _$PrescriptionModelToJson(this);

  // Getter for prescriptionDetails
  List<PrescriptionDetailModel> get medications => prescriptionDetails ?? [];

  static List<PrescriptionModel> getData() {
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
            notes: "After meal",
            quantity: 30,
            quantityUsed: 1,
            timeToUse: "Morning",
            drug: DrugModel(
                idDrug: 102,
                name: "Hapacol",
                indication: "For treating condition B",
                contraindication: "Do not use if condition C is present",
                uses: "Take one pill daily",
                sideEffect: "May cause side effect B",
                price: 30000.0,
                description: "This is a description of Drug B",
                code: "B002",
                unit: "Gói",
                idBrand: 2,
                idDrugCate: 2,
                drugImage:
                    "https://hapacol.vn/wp-content/uploads/2016/04/21.png"),
          ),
          PrescriptionDetailModel(
            idPreDetail: 1002,
            idDrug: 103,
            idPre: 1,
            notes: "Before bed",
            quantity: 60,
            quantityUsed: 2,
            timeToUse: "Evening",
            drug: DrugModel(
                idDrug: 103,
                name: "Promax new",
                indication: "For treating condition B",
                contraindication: "Do not use if condition C is present",
                uses: "Take one pill daily",
                sideEffect: "May cause side effect B",
                price: 6000.0,
                description: "This is a description of Drug B",
                code: "B002",
                unit: "ml",
                idBrand: 2,
                idDrugCate: 2,
                drugImage:
                    "https://cdn1.concung.com/2023/08/63592-103806-large_mobile/promax-new-an-huy.png"),
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
            drug: DrugModel(
                idDrug: 105,
                name: "Thuốc ho Prospan",
                indication: "For treating condition B",
                contraindication: "Do not use if condition C is present",
                uses: "Take one pill daily",
                sideEffect: "May cause side effect B",
                price: 230000.0,
                description: "This is a description of Drug B",
                code: "B002",
                unit: "Hộp",
                idBrand: 2,
                idDrugCate: 2,
                drugImage:
                    "https://nhathuocmedcare.vn/media/catalog/product/cache/7012753609bdb66174cd6f40c1c8efc9/5/_/5.3.png"),
          ),
        ],
      ),
    ];
  }

  String convertTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      return "${(difference.inDays / 7).floor()} weeks ago";
    }
  }
}

List<PrescriptionModel> generateSamplePrescriptions() {
  return [
    PrescriptionModel(
      idPre: 1001,
      idUser: 101,
      idHospital: 201,
      createdDate: DateTime.now(),
      doctorName: "Dr. John Doe",
      status: "active",
      revisitDate: DateTime.now(),
      roomRevisit: "A91",
      hospital: HospitalModel(
          idHospital: 100,
          name: "Phòng khám đa khoa bệnh viện Đại Học Y Dược",
          address: "413, Điện Biên Phủ, Phường 10, Quận 3",
          phone: "0988362384",
          createdDate: DateTime.now(),
          avatars:
              "https://upload.wikimedia.org/wikipedia/vi/thumb/4/42/Logo_Tr%C6%B0%E1%BB%9Dng_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_Y_D%C6%B0%E1%BB%A3c%2C_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_Hu%E1%BA%BF.svg/1024px-Logo_Tr%C6%B0%E1%BB%9Dng_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_Y_D%C6%B0%E1%BB%A3c%2C_%C4%90%E1%BA%A1i_h%E1%BB%8Dc_Hu%E1%BA%BF.svg.png"),
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
          idPre: 3001,
          notes: "After meals",
          quantity: 90,
          quantityUsed: 3,
          timeToUse: "Chiều",
        ),
      ],
    ),
    PrescriptionModel(
      idPre: 1002,
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
