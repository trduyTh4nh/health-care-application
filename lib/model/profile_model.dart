import 'package:json_annotation/json_annotation.dart';

part 'json/profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  int? idProfile;
  String? name;
  int? height;
  int? weight;
  DateTime? age;
  String? gender;
  String? address;
  int? idUser; // khóa ngoại
  ProfileModel(
      {this.idProfile,
      this.name,
      this.height,
      this.weight,
      this.age,
      this.gender,
      this.address,
      this.idUser});
  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
