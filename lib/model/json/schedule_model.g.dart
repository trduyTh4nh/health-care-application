// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) =>
    ScheduleModel(
      idDonThuoc: (json['idDonThuoc'] as num?)?.toInt(),
      status: json['status'] as String?,
      idSchedule: (json['idSchedule'] as num?)?.toInt(),
      idUser: (json['idUser'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ScheduleModelToJson(ScheduleModel instance) =>
    <String, dynamic>{
      'idSchedule': instance.idSchedule,
      'idDonThuoc': instance.idDonThuoc,
      'idUser': instance.idUser,
      'status': instance.status,
    };
