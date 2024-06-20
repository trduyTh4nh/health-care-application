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
  String? drugImage;

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
  this.idDrugCate,
  this.drugImage});

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
      drugImage: "https://www.imexpharm.com/Data/Sites/1/Product/8809/Paracetamol-IMEX-500mg-hop-100v.png"
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
      unit: "Gói",
      idBrand: 2,
      idDrugCate: 2,
      drugImage: "https://hapacol.vn/wp-content/uploads/2016/04/21.png"
    ),
    DrugModel(
      idDrug: 103,
      name: "Doraemon",
      ingredients: [4, 5, 6],
      indication: "For treating condition B",
      contraindication: "Do not use if condition C is present",
      uses: "Take one pill daily",
      sideEffect: "May cause side effect B",
      productionDate: DateTime(2022, 6, 15),
      expirationDate: DateTime(2023, 6, 15),
      price: 6000.0,
      description: "This is a description of Drug B",
      code: "B002",
      unit: "ml",
      idBrand: 2,
      idDrugCate: 2,
      drugImage: "https://thuocgiaphuc.vn/Uploads/HinhSP/com_plusvitca_c40gr_tung_lam_tcplc.jpg"
    ),
    DrugModel(
      idDrug: 104,
      name: "Thuốc nhỏ mắt OSLA",
      ingredients: [4, 5, 6],
      indication: "For treating condition B",
      contraindication: "Do not use if condition C is present",
      uses: "Take one pill daily",
      sideEffect: "May cause side effect B",
      productionDate: DateTime(2022, 6, 15),
      expirationDate: DateTime(2023, 6, 15),
      price: 1200.0,
      description: "This is a description of Drug B",
      code: "B002",
      unit: "Vỉ",
      idBrand: 2,
      idDrugCate: 2,
      drugImage: "https://eoffice.meraplion.com/admincp/api/storage/images/webhub/products/yo8c21nlowlphzb-29-11-2023-11-52-18.png"
    ),
     DrugModel(
      idDrug: 105,
      name: "Thuốc ho Prospan",
      ingredients: [4, 5, 6],
      indication: "For treating condition B",
      contraindication: "Do not use if condition C is present",
      uses: "Take one pill daily",
      sideEffect: "May cause side effect B",
      productionDate: DateTime(2022, 6, 15),
      expirationDate: DateTime(2023, 6, 15),
      price: 230000.0,
      description: "This is a description of Drug B",
      code: "B002",
      unit: "Hộp",
      idBrand: 2,
      idDrugCate: 2,
      drugImage: "https://prospan.com.vn/wp-content/uploads/2017/04/03-vo-hop-vi.png"
    ),
    // Add more sample data as needed
  ];
}


