import 'dart:convert';
import 'dart:developer';

import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/profile_model.dart';
import 'package:app_well_mate/model/user.dart';
import 'package:app_well_mate/model/user_info_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiRepo {
  API api = API();
  final Dio _dio = Dio();
  Map<String, dynamic> header(String token) {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
  }

  Future<bool> login(String email, String password) async {
    Map<String, dynamic> body = {"email": email, "password": password};
    try {
      Response res = await api.sendRequest.post("/access/login",
          data: body, options: Options(headers: header('no_token')));
      var data = res.data;
      log(data["metadata"]["user"].toString());
      if (res.statusCode == 200) {
        bool r = await SecureStorage.saveUser(res.data["metadata"]["token"],
            jsonEncode(res.data["metadata"]["user"]));
        return r;
      }
      return res.statusCode == 200;
    } catch (ex) {
      log(ex.toString());
      return false;
    }
  }

  Future<String> register(String userName, String name, String email,
      String phoneNumber, String passWord) async {
    Map<String, dynamic> body = {
      'username': userName,
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'password': passWord,
    };
    try {
      Response response = await api.sendRequest.post('/access/register',
          data: body,
          options: Options(
            headers: header("no_token"),
          ));

      log("body: ${response.data["metadata"]["metadata"]["user"]}");
      var data = response.data["metadata"]["metadata"]["user"];
      User user = User.fromJson(data);
      if (response.statusCode == 201) {
        return user.idUser.toString();
      } else {
        print("fail");
        return "register fail";
      }
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  Future<InfoUserModel?> getInfoUser() async {
    try {
      String token = await SecureStorage.getToken();
      int userId = await SecureStorage.getUserId();

      Response res = await api.sendRequest.get(
        '/user/getUserInformation/$userId',
        options: Options(headers: header(token)),
      );

      print('Raw JSON Data: ${res.data}');
      if (res.statusCode == 200) {
        var data = res.data["metadata"];
        InfoUserModel infoUserModel = InfoUserModel.fromJson(data);
        print('Parsed Data: ${infoUserModel.profile?.weight}');
        return infoUserModel;
      } else {
        print("Failed to get user information");
        return null;
      }
    } catch (ex) {
      print("Failed Get User Info : $ex");
      rethrow;
    }
  }

  Future<bool> updateProfile(
      ProfileModel profile, String imageSingleFiles) async {
    try {
      String token = await SecureStorage.getToken();
      int user = await SecureStorage.getUserId();
      MultipartFile file = await MultipartFile.fromFile(imageSingleFiles);
      final body = FormData.fromMap({
        "singlefile": file,
        "height": profile.height,
        "weight": profile.weight,
        "gender": profile.gender,
        "age": profile.age,
        "address": profile.address,
        "phone": profile.phone,
        "full_name": profile.fullName,
      });
      Response res = await api.sendRequest.put(
        '/user/updateProfile/$user',
        options: Options(headers: header(token)),
        data: body,
      );

      if (res.statusCode == 200) {
        print("Update Profile Success");
        return true;
      } else {
        print("Update Profile Fail");
        return false;
      }
    } catch (ex) {
      print("Failled update Profile: $ex");
      rethrow;
    }
  }
}
