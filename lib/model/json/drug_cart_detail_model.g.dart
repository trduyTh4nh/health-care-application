// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../drug_cart_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrugCartDetailModel _$DrugCartDetailModelFromJson(Map<String, dynamic> json) =>
    DrugCartDetailModel(
      idDrugCartDetail: (json['idDrugCartDetail'] as num?)?.toInt(),
      idDrug: (json['idDrug'] as num?)?.toInt(),
      addedDate: json['addedDate'] == null
          ? null
          : DateTime.parse(json['addedDate'] as String),
      quantity: (json['quantity'] as num?)?.toInt(),
    )..idCart = (json['idCart'] as num?)?.toInt();

Map<String, dynamic> _$DrugCartDetailModelToJson(
        DrugCartDetailModel instance) =>
    <String, dynamic>{
      'idDrugCartDetail': instance.idDrugCartDetail,
      'idDrug': instance.idDrug,
      'idCart': instance.idCart,
      'addedDate': instance.addedDate?.toIso8601String(),
      'quantity': instance.quantity,
    };
