// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../schedule_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDetailModel _$ScheduleDetailModelFromJson(Map<String, dynamic> json) =>
    ScheduleDetailModel(
      idScheduleDetail: (json['idScheduleDetail'] as num?)?.toInt(),
      idPreDetail: (json['idPreDetail'] as num?)?.toInt(),
      idSchedule: (json['idSchedule'] as num?)?.toInt(),
      status: json['status'] as String?,
      timeOfUse: json['timeOfUse'] as TimeOfDay?
    );

Map<String, dynamic> _$ScheduleDetailModelToJson(
        ScheduleDetailModel instance) =>
    <String, dynamic>{
      'idScheduleDetail': instance.idScheduleDetail,
      'idPreDetail': instance.idPreDetail,
      'idSchedule': instance.idSchedule,
      'status': instance.status,
      'timeOfUse': instance.timeOfUse
    };
