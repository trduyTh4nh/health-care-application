import 'package:app_well_mate/model/drug_cart_model.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json/drug_cart_detail_model.g.dart';

@JsonSerializable()
class DrugCartDetailModel{
  int? idDrugCartDetail;
  int? idDrug; // khóa ngoại
  DrugModel? drug;
  int? idCart; // khóa ngoại
  DateTime? addedDate;
  int? quantity;
  DrugCartModel? drugCart;
  DrugCartDetailModel({
    this.idDrugCartDetail,
    this.idDrug,
    this.addedDate,
    this.quantity,
    this.drug,
    this.drugCart
  });


  factory DrugCartDetailModel.fromJson(Map<String, dynamic> json) => _$DrugCartDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$DrugCartDetailModelToJson(this);


}