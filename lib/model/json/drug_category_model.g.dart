// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../drug_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrugCategoryModel _$DrugCategoryModelFromJson(Map<String, dynamic> json) =>
    DrugCategoryModel(
      idLoai: (json['idLoai'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$DrugCategoryModelToJson(DrugCategoryModel instance) =>
    <String, dynamic>{
      'idLoai': instance.idLoai,
      'name': instance.name,
      'description': instance.description,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
