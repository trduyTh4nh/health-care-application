import 'package:json_annotation/json_annotation.dart';

part 'json/drug_cart_model.g.dart';

@JsonSerializable()
class DrugCartModel {
  int? idCart;
  int? quantity;
  DateTime? createdDate;
  double? totalPrice;
  int? idUser; // khóa ngoại

  DrugCartModel(
      {this.idCart,
      this.quantity,
      this.createdDate,
      this.totalPrice,
      this.idUser});

  factory DrugCartModel.fromJson(Map<String, dynamic> json) =>
      _$DrugCartModelFromJson(json);
  Map<String, dynamic> toJson() => _$DrugCartModelToJson(this);
}

var listDrugCartModel = [
   DrugCartModel(idCart: 101, quantity: 3, totalPrice: 75000, idUser: 1),
  DrugCartModel(idCart: 102, quantity: 2, totalPrice: 60000, idUser: 1),
  DrugCartModel(idCart: 103, quantity: 1, totalPrice: 30000, idUser: 1),
];