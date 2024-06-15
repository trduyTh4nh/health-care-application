import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json/prescription_detail_model.g.dart';

@JsonSerializable()
class PrescriptionDetailModel {
  int? idPreDetail;
  String? notes;
  int? quantity;
  String? timeToUse;
  double? quantityToUse;
  int? idDrug; // khóa ngoại
  int? idPre; // khóa ngoại
  DrugModel? drug;
  PrescriptionModel? prescription;
  PrescriptionDetailModel({this.idPreDetail, this.idDrug, this.idPre, this.notes, this.quantity, this.quantityToUse, this.timeToUse, this.prescription, this.drug});

  factory PrescriptionDetailModel.fromJson(Map<String, dynamic> json) => _$PrescriptionDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$PrescriptionDetailModelToJson(this);
}
