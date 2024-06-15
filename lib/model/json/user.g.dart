// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      idUser: (json['idUser'] as num?)?.toInt(),
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'idUser': instance.idUser,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'userName': instance.userName,
    };
