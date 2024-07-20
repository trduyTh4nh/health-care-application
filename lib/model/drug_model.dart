import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DrugModel {
  int? idDrug;
  String? name;
  String? ingredients;
  String? indication;
  String? contraindication;
  String? uses;
  String? sideEffect;
  String? productionDate;
  String? expirationDate;
  double? price;
  String? description;
  String? code;
  String? unit;
  int? idBrand;
  int? idDrugCate;
  String? drugImage;
  DrugModel(
      {this.idDrug,
      this.name,
      this.ingredients,
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

  factory DrugModel.fromJson(Map<String, dynamic> json) => DrugModel(
      idDrug: json["id_drug"] ?? 0,
      name: json["name"] ?? "",
      ingredients: json["ingredient"] ?? "",
      indication: json["indication"] ?? "",
      contraindication: json["contraindication"] ?? "",
      uses: json["uses"] ?? "",
      sideEffect: json["side_effect"] ?? "",
      productionDate: json["production_date"] ?? "",
      price: double.parse(json["price"]),
      description: json["description"] ?? "",
      code: json["code"],
      unit: json["unit"]);

  Map<String, dynamic> toJson() => {
        "id_drug": idDrug,
        "name": name,
        "ingredient": ingredients,
        "indication": indication,
        "contraindication": contraindication,
        "uses": uses,
        "side_effect": sideEffect,
        "production_date": productionDate,
        "expiration_date": expirationDate,
        "price": price,
        "description": description,
        "code": code,
        "unit": unit,
        "id_brand": idBrand,
        "id_drug_cate": idDrugCate,
        "drug_image": drugImage,
      };
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
        indication: "For treating condition A",
        contraindication: "Do not use if condition B is present",
        uses: "Use as directed by your physician",
        sideEffect: "May cause side effect A",
        price: 50000.0,
        description: "This is a description of Drug A",
        code: "A001",
        unit: "mg",
        idBrand: 1,
        idDrugCate: 1,
        drugImage:
            "https://www.imexpharm.com/Data/Sites/1/Product/8809/Paracetamol-IMEX-500mg-hop-100v.png"),
    DrugModel(
        idDrug: 102,
        name: "Hapacol",
        indication: "For treating condition B",
        contraindication: "Do not use if condition C is present",
        uses: "Take one pill daily",
        sideEffect: "May cause side effect B",
        price: 30000.0,
        description: "This is a description of Drug B",
        code: "B002",
        unit: "Gói",
        idBrand: 2,
        idDrugCate: 2,
        drugImage: "https://hapacol.vn/wp-content/uploads/2016/04/21.png"),
    DrugModel(
        idDrug: 103,
        name: "Promax new",
        indication: "For treating condition B",
        contraindication: "Do not use if condition C is present",
        uses: "Take one pill daily",
        sideEffect: "May cause side effect B",
        price: 6000.0,
        description: "This is a description of Drug B",
        code: "B002",
        unit: "ml",
        idBrand: 2,
        idDrugCate: 2,
        drugImage:
            "https://cdn1.concung.com/2023/08/63592-103806-large_mobile/promax-new-an-huy.png"),
    DrugModel(
        idDrug: 104,
        name: "Thuốc nhỏ mắt OSLA",
        indication: "For treating condition B",
        contraindication: "Do not use if condition C is present",
        uses: "Take one pill daily",
        sideEffect: "May cause side effect B",
        price: 1200.0,
        description: "This is a description of Drug B",
        code: "B002",
        unit: "Vỉ",
        idBrand: 2,
        idDrugCate: 2,
        drugImage:
            "https://eoffice.meraplion.com/admincp/api/storage/images/webhub/products/yo8c21nlowlphzb-29-11-2023-11-52-18.png"),
    DrugModel(
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
    // Add more sample data as needed
  ];
}
