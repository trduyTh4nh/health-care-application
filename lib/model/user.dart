import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'json/user.g.dart';

@JsonSerializable()
class User {
  int? idUser;
  String? email;
  String? password;
  String? role;
  String? userName;

  User({this.idUser, this.email, this.password, this.role, this.userName});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);



  
}



void test(){
    String jsonString = '''
  {
    "idUser": 1,
    "email": "example@example.com",
    "password": "123456",
    "role": "admin",
    "userName": "ExampleUser"
  }
  ''';
    Map<String, dynamic> userMap = jsonDecode(jsonString);
    User user = User.fromJson(userMap);

    print('User ID: ${user.idUser}');
    print('Email: ${user.email}');
    print('Username: ${user.userName}');
}
