// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      id_address: (json['id_address'] as num?)?.toInt(),
      address: json['address'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id_address': instance.id_address,
      'address': instance.address,
    };
