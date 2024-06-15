import 'package:json_annotation/json_annotation.dart';

part 'json/order_detail_model.g.dart';

@JsonSerializable()
class OrderDetailModel{
  int? idDetailOrder;
  int? idDrug; // khóa ngoại
  int? quantity;
  String? notes;
  int? idOrder; // khóa ngoại


  OrderDetailModel({
    this.idDetailOrder,
    this.idDrug,
    this.idOrder,
    this.notes,
    this.quantity
  });



  factory OrderDetailModel.fromJson(Map<String, dynamic> json) => _$OrderDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);

}