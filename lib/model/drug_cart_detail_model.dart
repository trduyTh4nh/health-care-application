import 'package:json_annotation/json_annotation.dart';

part 'json/drug_cart_detail_model.g.dart';

@JsonSerializable()
class DrugCartDetailModel{
  int? idDrugCartDetail;
  int? idDrug; // khóa ngoại
  int? idCart; // khóa ngoại
  DateTime? addedDate;
  int? quantity;

  DrugCartDetailModel({
    this.idDrugCartDetail,
    this.idDrug,
    this.addedDate,
    this.quantity
  });


  factory DrugCartDetailModel.fromJson(Map<String, dynamic> json) => _$DrugCartDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$DrugCartDetailModelToJson(this);


}