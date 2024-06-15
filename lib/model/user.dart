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
  String? imgUser;
  User({
    this.idUser,
    this.email,
    this.password,
    this.role,
    this.userName,
    this.imgUser,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['idUser'] as int?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      userName: json['userName'] as String?,
      imgUser: json['imgUser'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'email': email,
      'password': password,
      'role': role,
      'userName': userName,
      'imgUser': imgUser,
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
