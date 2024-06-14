import 'package:json_annotation/json_annotation.dart';

part 'json/brand_model.g.dart';

@JsonSerializable()
class BrandModel {
  int? idBrand;
  String? name;
  String? address;
  String? phone;
  String? email;
  String? description;
  String? representative;
  String? website;

  BrandModel({this.idBrand, this.name, this.address, this.phone, this.description, this.email, this.representative, this.website});

  factory BrandModel.fromJson(Map<String, dynamic> json) => _$BrandModelFromJson(json);
  Map<String, dynamic> toJson() => _$BrandModelToJson(this);
}