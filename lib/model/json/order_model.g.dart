// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      idUser: (json['idUser'] as num?)?.toInt(),
      datePay: json['datePay'] == null
          ? null
          : DateTime.parse(json['datePay'] as String),
      paymentMethod: json['paymentMethod'] as String?,
      status: json['status'] as String?,
      notes: json['notes'] as String?,
      totalMoney: (json['totalMoney'] as num?)?.toInt(),
    )..idOrder = (json['idOrder'] as num?)?.toInt();

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'idOrder': instance.idOrder,
      'idUser': instance.idUser,
      'datePay': instance.datePay?.toIso8601String(),
      'paymentMethod': instance.paymentMethod,
      'status': instance.status,
      'notes': instance.notes,
      'totalMoney': instance.totalMoney,
    };
