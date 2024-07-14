import 'dart:convert';
import 'dart:developer';

import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class ApiRepo {
  API api = API();
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
      if(res.statusCode == 200){
        bool r = await SecureStorage.saveUser(res.data["metadata"]["token"], jsonEncode(res.data["metadata"]["user"]));
        return r;
      }
      return res.statusCode == 200;
    } catch (ex) {
      log(ex.toString());
      return false;
    }
  }
}
