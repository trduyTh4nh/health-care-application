import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json/user.g.dart';

@JsonSerializable()
class User {
  int? idUser;
  String? email;
  String? password;
  String? role;
  String? userName;
  ProfileUserModel? profile;

  User({
    this.idUser,
    this.email,
    this.password,
    this.role,
    this.userName,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: int.parse(json['id_user']),
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'].toString(),
      userName: json['name'] ?? "",
      profile: json['profile'] != null
          ? ProfileUserModel.fromJson(json['profile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'email': email,
      'password': password,
      'role': role,
      'name': userName,
      // 'imgUser': imgUser,
      'profile': profile?.toJson(),
    };
  }
}

class DataUsers {
  List<User> users = [];

  Future<void> loadUsersFromJson() async {
    // Đọc file JSON từ thư mục assets
    final String response = await rootBundle.loadString('assets/users.json');
    final List<dynamic> data = jsonDecode(response);

    // Chuyển đổi mỗi mục trong JSON thành đối tượng User
    users = data.map((json) => User.fromJson(json)).toList();
  }
}

class ProfileUserModel {
  int? idResume;
  int? height;
  int? weight;
  int? age;
  String? gender;
  String? address;
  int? idUser;
  String? avatar;
  String? phone;
  String? fullName;

  ProfileUserModel({
    this.idResume,
    this.height,
    this.weight,
    this.age,
    this.gender,
    this.address,
    this.idUser,
    this.avatar,
    this.phone,
    this.fullName,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      idResume: json['id_resume'] is int
          ? json['id_resume']
          : int.tryParse(json['id_resume'].toString()),
      height: json['height'] is int
          ? json['height']
          : int.tryParse(json['height'].toString()),
      weight: json['weight'] is double
          ? json['weight']
          : int.tryParse(json['weight'].toString()),
      age: json['age'] is int
          ? json['age']
          : int.tryParse(json['age'].toString()),
      gender: json['gender']?.toString(),
      address: json['address']?.toString(),
      idUser: json['id_user'] is int
          ? json['id_user']
          : int.tryParse(json['id_user'].toString()),
      avatar: json['avatar']?.toString(),
      phone: json['phone']?.toString(),
      fullName: json['full_name']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_resume': idResume,
      'height': height,
      'weight': weight,
      'age': age,
      'gender': gender,
      'address': address,
      'id_user': idUser,
      'avatar': avatar,
      'phone': phone,
      'full_name': fullName,
    };
  }
}
