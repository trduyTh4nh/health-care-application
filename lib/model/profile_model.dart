import 'package:json_annotation/json_annotation.dart';

part 'json/profile_model.g.dart';

// @JsonSerializable()
class ProfileModel {
  int? idProfile;

  int? height;
  int? weight;
  int? age;
  String? gender;
  String? address;
  int? idUser; // khóa ngoại
  String? avtUser;
  ProfileModel(
      {this.idProfile,
      this.height,
      this.weight,
      this.age,
      this.gender,
      this.address,
      this.idUser,
      this.avtUser});
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
