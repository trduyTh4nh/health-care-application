// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: (json['id_notify'] as num?)?.toInt(),
      content: json['content'] as String?,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      priority: json['priority'].toString() as String?,
      status: json['status'] as bool?,
      userId: (json['id_user'] as num?)?.toInt(),
      idOrder: (json['idOrder'] as num?)?.toInt(),
      idPayment: (json['id_invoice'] as num?)?.toInt(),
      idDonThuocCT: (json['schedule_detail']['id_app_detail'] as num?)?.toInt(),
      idScheduleDetail: (json['id_schedule_detail'] as num?)?.toInt()
    )
      ..isComfirmed = json['is_confirmed'] as bool?
      ..idDonThuocCT = (json['schedule_detail']['id_app_detail'] as num?)?.toInt();

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'time': instance.time?.toIso8601String(),
      'priority': instance.priority,
      'status': instance.status,
      'isComfirmed': instance.isComfirmed,
      'userId': instance.userId,
      'idDonThuocCT': instance.idDonThuocCT,
      'idOrder': instance.idOrder,
      'idPayment': instance.idPayment
    };
