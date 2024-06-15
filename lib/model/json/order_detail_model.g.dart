// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) =>
    OrderDetailModel(
      idDetailOrder: (json['idDetailOrder'] as num?)?.toInt(),
      idDrug: (json['idDrug'] as num?)?.toInt(),
      idOrder: (json['idOrder'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderDetailModelToJson(OrderDetailModel instance) =>
    <String, dynamic>{
      'idDetailOrder': instance.idDetailOrder,
      'idDrug': instance.idDrug,
      'quantity': instance.quantity,
      'notes': instance.notes,
      'idOrder': instance.idOrder,
    };
