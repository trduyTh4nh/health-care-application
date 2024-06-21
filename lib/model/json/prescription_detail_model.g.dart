// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../prescription_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionDetailModel _$PrescriptionDetailModelFromJson(
        Map<String, dynamic> json) =>
    PrescriptionDetailModel(
      idPreDetail: (json['idPreDetail'] as num?)?.toInt(),
      idDrug: (json['idDrug'] as num?)?.toInt(),
      idPre: (json['idPre'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      timeToUse: json['timeToUse'] as String?,
      amount: json['amount'] as String?
    );

Map<String, dynamic> _$PrescriptionDetailModelToJson(
        PrescriptionDetailModel instance) =>
    <String, dynamic>{
      'idPreDetail': instance.idPreDetail,
      'notes': instance.notes,
      'quantity': instance.quantity,
      'timeToUse': instance.timeToUse,
      'quantityUsed': instance.quantityUsed,
      'idDrug': instance.idDrug,
      'idPre': instance.idPre,
      'amount': instance.amount
    };
