import 'package:app_well_mate/model/drug_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:app_well_mate/model/prescription_model.dart';
part 'json/prescription_detail_model.g.dart';

@JsonSerializable()
class PrescriptionDetailModel {
  int? idPreDetail;
  int? idDrug;
  int? idPre;
  String? notes;
  int? quantity;
  int? quantityUsed;
  String? timeToUse;
  String? amount;
  int? amountPerConsumption;
  DrugModel? drug;
  PrescriptionModel? prescription;

  PrescriptionDetailModel({
    this.idPreDetail,
    this.idDrug,
    this.idPre,
    this.notes,
    this.quantity,
    this.quantityUsed,
    this.timeToUse,
    this.amount,
    this.amountPerConsumption,
    this.drug,
    this.prescription,
  });

  factory PrescriptionDetailModel.fromJson(Map<String, dynamic> json) =>
      PrescriptionDetailModel(
        idPreDetail: json["id_app_detail"] ?? 0,
        notes: json["notes"] ?? "",
        timeToUse: json["time_to_use"] ?? "",
        quantityUsed: json["quantity_used"] ?? 0,
        idPre: json["id_drug_application"] ?? 0,
      );
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
        idPre: 1001, //id của đơn thuốc''

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
        amount: "1 lần 3 viên"),
    PrescriptionDetailModel(
        idPreDetail: 1002,
        notes: "Sau bửa tối",
        quantity: 60,
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
        timeToUse: "Tối",
        quantityUsed: 10,
        idDrug: 102,
        idPre: 1002, // id của đơn thuốc
        amount: "1 lần 1/2 viên"),
  ];
}
