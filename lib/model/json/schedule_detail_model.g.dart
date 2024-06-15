// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../schedule_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDetailModel _$ScheduleDetailModelFromJson(Map<String, dynamic> json) =>
    ScheduleDetailModel(
      idScheduleDetail: (json['idScheduleDetail'] as num?)?.toInt(),
      idPrescriptionDetail: (json['idDrugCartDetail'] as num?)?.toInt(),
      idSchedule: (json['idSchedule'] as num?)?.toInt(),
      quantityUsed: (json['quantityUsed'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ScheduleDetailModelToJson(
        ScheduleDetailModel instance) =>
    <String, dynamic>{
      'idScheduleDetail': instance.idScheduleDetail,
      'idDrugCartDetail': instance.idPrescriptionDetail,
      'quantityUsed': instance.quantityUsed,
      'idSchedule': instance.idSchedule,
      'status': instance.status,
    };
