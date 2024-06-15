// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../brand_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandModel _$BrandModelFromJson(Map<String, dynamic> json) => BrandModel(
      idBrand: (json['idBrand'] as num?)?.toInt(),
      name: json['name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      description: json['description'] as String?,
      email: json['email'] as String?,
      representative: json['representative'] as String?,
      website: json['website'] as String?,
    );

Map<String, dynamic> _$BrandModelToJson(BrandModel instance) =>
    <String, dynamic>{
      'idBrand': instance.idBrand,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'description': instance.description,
      'representative': instance.representative,
      'website': instance.website,
    };
