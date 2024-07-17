import 'dart:developer';

import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';

class CartRepo {
  API api = API();
  Future<String> createCart(String id) async {
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.post("/cart/insertCart/$id",
          options: Options(headers: header(token)));
      log(res.data["data"]["message"].toString());
      return res.data["data"]["message"].toString();
    } catch (ex) {
      if (ex is DioException) {
        DioException excep = ex;
        log(ex.response!.data.toString());
        return "Fail";
      }
      return "Fail hard";
    }
  }

  Future<String> getAllDrugInCart(int id) async {
    String token = await SecureStorage.getToken();
    print("token cua user: $token");
    try {
      Response res = await api.sendRequest.get("/cart/getAllDrugInCart/$id",
          options: Options(headers: header(token)));

      if (res.statusCode == 200) {
        print("Body : ${res.data}");
        return "GetDataSuccess";
      } else {
        return "Fail";
      }
    } catch (ex) {
      print(ex);
      return "Faill nang roi";
    }
  }
}
