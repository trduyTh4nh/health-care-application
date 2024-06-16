import 'package:json_annotation/json_annotation.dart';

part 'json/prescription_detail_model.g.dart';

@JsonSerializable()
class PrescriptionDetailModel {
  int? idPreDetail;
  String? notes;
  int? quantity;
  String? timeToUse;
  double? quantityUsed;
  int? idDrug; // khóa ngoại
  int? idPre; // khóa ngoại // id của đơn thuốc
  String? amount; // ví dụ 1 lần 3 viên

  PrescriptionDetailModel(
      {this.idPreDetail,
      this.idDrug,
      this.idPre,
      this.notes,
      this.quantity,
      this.quantityUsed,
      this.timeToUse,
      this.amount});

  factory PrescriptionDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$PrescriptionDetailModelToJson(this);
}

List<PrescriptionDetailModel> generateSamplePrescriptionDetails() {
  return [
    PrescriptionDetailModel(
      idPreDetail: 1001,
      notes: "Sau khi ăn",
      quantity: 30,
      timeToUse: "Sáng",
      quantityUsed: 10,
      idDrug: 101,
      idPre: 1001, //id của đơn thuốc
      amount: "1 lần 3 viên"

    ),
    PrescriptionDetailModel(
      idPreDetail: 1002,
      notes: "Sau bửa tối",
      quantity: 60,
      timeToUse: "Tối",
      quantityUsed: 10,
      idDrug: 102,
      idPre: 1002, // id của đơn thuốc
      amount: "1 lần 1/2 viên"
    ),
  ];
}
