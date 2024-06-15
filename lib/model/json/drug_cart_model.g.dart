// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../drug_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrugCartModel _$DrugCartModelFromJson(Map<String, dynamic> json) =>
    DrugCartModel(
      idCart: (json['idCart'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      idUser: (json['idUser'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DrugCartModelToJson(DrugCartModel instance) =>
    <String, dynamic>{
      'idCart': instance.idCart,
      'quantity': instance.quantity,
      'createdDate': instance.createdDate?.toIso8601String(),
      'totalPrice': instance.totalPrice,
      'idUser': instance.idUser,
    };
