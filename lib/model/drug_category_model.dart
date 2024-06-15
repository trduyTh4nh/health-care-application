import 'package:json_annotation/json_annotation.dart';

part 'json/drug_category_model.g.dart';

@JsonSerializable()
class DrugCategoryModel{
  int? idLoai;
  String? name;
  String? description;
  DateTime? createdDate;

  DrugCategoryModel({this.idLoai, this.name, this.description, this.createdDate});

  factory DrugCategoryModel.fromJson(Map<String, dynamic> json) => _$DrugCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$DrugCategoryModelToJson(this);
}