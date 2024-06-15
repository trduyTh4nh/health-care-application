import 'package:json_annotation/json_annotation.dart';

part 'json/drug_model.g.dart';

@JsonSerializable()
class DrugModel {
  int? idDrug;
  String? name;
  List<int>? ingredients = [];
  String? indication;
  String? contraindication;
  String? uses;
  String? sideEffect;
  DateTime? productionDate;
  DateTime? expirationDate;
  double? price;
  String? description;
  String? code;
  String? unit;
  int? idBrand;
  int? idDrugCate;

  DrugModel({this.idDrug, this.name, this.ingredients, 
  this.indication,
  this.contraindication,
  this.uses,
  this.sideEffect, 
  this.productionDate,
  this.expirationDate,
  this.price,
  this.description,
  this.code,
  this.unit,
  this.idBrand,
  this.idDrugCate});

  factory DrugModel.fromJson(Map<String, dynamic> json) => _$DrugModelFromJson(json);
  Map<String, dynamic> toJson() => _$DrugModelToJson(this);
}

// class Ingredient {
//   int? id;
//   String? name;
//   double? quantity;
//   String? unit;
// }
