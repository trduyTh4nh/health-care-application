// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      idProfile: (json['idProfile'] as num?)?.toInt(),
      name: json['name'] as String?,
      height: (json['height'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      age: json['age'] == null ? null : DateTime.parse(json['age'] as String),
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      idUser: (json['idUser'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'idProfile': instance.idProfile,
      'name': instance.name,
      'height': instance.height,
      'weight': instance.weight,
      'age': instance.age?.toIso8601String(),
      'gender': instance.gender,
      'address': instance.address,
      'idUser': instance.idUser,
    };
