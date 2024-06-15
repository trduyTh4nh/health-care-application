// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hospital_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalModel _$HospitalModelFromJson(Map<String, dynamic> json) =>
    HospitalModel(
      idHospital: (json['idHospital'] as num?)?.toInt(),
      name: json['name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      contactInformation: json['contactInformation'] as String?,
    );

Map<String, dynamic> _$HospitalModelToJson(HospitalModel instance) =>
    <String, dynamic>{
      'idHospital': instance.idHospital,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'createdDate': instance.createdDate?.toIso8601String(),
      'contactInformation': instance.contactInformation,
    };


// Hàm fromJson: Dùng để tạo một đối tượng từ JSON.
// Hàm toJson: Dùng để chuyển đổi một đối tượng thành JSON.