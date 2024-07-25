// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../drug_cart_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
DrugCartDetailModel _$DrugCartDetailModelFromJson(Map<String, dynamic> json) =>
    DrugCartDetailModel(
      idDrugCartDetail: (json['id_cart_detail'] as num?)?.toInt(),
      idDrug: (json['id_drug'] as num?)?.toInt(),
      idCart: (json['id_cart'] as num?)?.toInt(),
      addedDate: json['date_add'] == null
          ? null
          : DateTime.parse(json['date_add'] as String),
      quantity: (json['quantity'] as num?)?.toInt(),
      quantityDrugDetail: (json['quantityDrugDetail'] as num?)?.toInt(),
      drug: json['drug'] == null
          ? null
          : DrugModel.fromJson(json['drug'] as Map<String, dynamic>),
      idAppDetail: json["id_app_detail"] ?? -1
    );

Map<String, dynamic> _$DrugCartDetailModelToJson(
        DrugCartDetailModel instance) =>
    <String, dynamic>{
      'id_cart_detail': instance.idDrugCartDetail,
      'id_drug': instance.idDrug,
      'id_cart': instance.idCart,
      'date_add': instance.addedDate?.toIso8601String(),
      'quantity': instance.quantity,
      'quantityDrugDetail': instance.quantityDrugDetail,
      'drug': instance.drug?.toJson(),
    };
