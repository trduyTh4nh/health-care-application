// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: (json['id'] as num?)?.toInt(),
      content: json['content'] as String?,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      priority: json['priority'] as String?,
      status: json['status'] as bool?,
      userId: (json['userId'] as num?)?.toInt(),
      idOrder: (json['idOrder'] as num?)?.toInt(),
      idPayment: (json['idPayment'] as num?)?.toInt(),
      idDonThuocCT: (json['idOrder'] as num?)?.toInt(),
    )
      ..isComfirmed = json['isComfirmed'] as bool?
      ..idDonThuocCT = (json['idDonThuocCT'] as num?)?.toInt();

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
