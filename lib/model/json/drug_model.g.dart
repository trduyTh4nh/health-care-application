// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../drug_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrugModel _$DrugModelFromJson(Map<String, dynamic> json) => DrugModel(
    idDrug: (json['idDrug'] as num?)?.toInt(),
    name: json['name'] as String?,
    ingredients: (json['ingredients'] as List<dynamic>?)
        ?.map((e) => (e as num).toInt())
        .toList(),
    indication: json['indication'] as String?,
    contraindication: json['contraindication'] as String?,
    uses: json['uses'] as String?,
    sideEffect: json['sideEffect'] as String?,
    productionDate: json['productionDate'] == null
        ? null
        : DateTime.parse(json['productionDate'] as String),
    expirationDate: json['expirationDate'] == null
        ? null
        : DateTime.parse(json['expirationDate'] as String),
    price: (json['price'] as num?)?.toDouble(),
    description: json['description'] as String?,
    code: json['code'] as String?,
    unit: json['unit'] as String?,
    idBrand: (json['idBrand'] as num?)?.toInt(),
    idDrugCate: (json['idDrugCate'] as num?)?.toInt(),
    drugImage: json['drugImage'] as String?);

Map<String, dynamic> _$DrugModelToJson(DrugModel instance) => <String, dynamic>{
      'idDrug': instance.idDrug,
      'name': instance.name,
      'ingredients': instance.ingredients,
      'indication': instance.indication,
      'contraindication': instance.contraindication,
      'uses': instance.uses,
      'sideEffect': instance.sideEffect,
      'productionDate': instance.productionDate?.toIso8601String(),
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'price': instance.price,
      'description': instance.description,
      'code': instance.code,
      'unit': instance.unit,
      'idBrand': instance.idBrand,
      'idDrugCate': instance.idDrugCate,
      'drugImage': instance.drugImage
    };
