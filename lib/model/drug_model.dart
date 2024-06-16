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



List<DrugModel> generateSampleDrugs() {
  return [
    DrugModel(
      idDrug: 101,
      name: "Paracetamol",
      ingredients: [1, 2, 3],
      indication: "For treating condition A",
      contraindication: "Do not use if condition B is present",
      uses: "Use as directed by your physician",
      sideEffect: "May cause side effect A",
      productionDate: DateTime(2022, 1, 1),
      expirationDate: DateTime(2023, 1, 1),
      price: 50000.0,
      description: "This is a description of Drug A",
      code: "A001",
      unit: "mg",
      idBrand: 1,
      idDrugCate: 1,
    ),
    DrugModel(
      idDrug: 102,
      name: "Hapacol",
      ingredients: [4, 5, 6],
      indication: "For treating condition B",
      contraindication: "Do not use if condition C is present",
      uses: "Take one pill daily",
      sideEffect: "May cause side effect B",
      productionDate: DateTime(2022, 6, 15),
      expirationDate: DateTime(2023, 6, 15),
      price: 30000.0,
      description: "This is a description of Drug B",
      code: "B002",
      unit: "ml",
      idBrand: 2,
      idDrugCate: 2,
    ),
    // Add more sample data as needed
  ];
}


