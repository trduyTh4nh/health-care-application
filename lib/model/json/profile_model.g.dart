// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      idProfile: (json['idProfile'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      idUser: (json['id_user'] as num?)?.toInt(),
      avtUser: (json['avatar'] as String?),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'idProfile': instance.idProfile,
      'height': instance.height,
      'weight': instance.weight,
      'age': instance.age,
      'gender': instance.gender,
      'address': instance.address,
      'id_user': instance.idUser,
      'singlefile': instance.avtUser,
    };
