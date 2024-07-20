// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../prescription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionModel _$PrescriptionModelFromJson(Map<String, dynamic> json) =>
    PrescriptionModel(
      idPre: (json['id'] as num?)?.toInt(),
      idUser: (json['idUser'] as num?)?.toInt(),
      idHospital: (json['idHospital'] as num?)?.toInt(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      doctorName: json['doctorName'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PrescriptionModelToJson(PrescriptionModel instance) =>
    <String, dynamic>{
      'idPre': instance.idPre,
      'createdDate': instance.createdDate?.toIso8601String(),
      'doctorName': instance.doctorName,
      'status': instance.status,
      'idUser': instance.idUser,
      'idHospital': instance.idHospital,
    };
