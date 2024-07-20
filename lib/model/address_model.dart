import 'package:json_annotation/json_annotation.dart';

part 'json/address_model.g.dart';

@JsonSerializable()
class AddressModel {
  int? id_address;
  String? address;
  AddressModel(
      {this.id_address,
      this.address});
  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

