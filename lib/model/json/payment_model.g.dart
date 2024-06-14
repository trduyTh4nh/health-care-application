// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      idPayment: (json['idPayment'] as num?)?.toInt(),
      datePay: json['datePay'] == null
          ? null
          : DateTime.parse(json['datePay'] as String),
      paymentMethod: json['paymentMethod'] as String?,
      status: json['status'] as bool?,
      notes: json['notes'] as String?,
      totalMoney: (json['totalMoney'] as num?)?.toDouble(),
      idOrder: (json['idOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'idPayment': instance.idPayment,
      'datePay': instance.datePay?.toIso8601String(),
      'paymentMethod': instance.paymentMethod,
      'status': instance.status,
      'notes': instance.notes,
      'totalMoney': instance.totalMoney,
      'idOrder': instance.idOrder,
    };
