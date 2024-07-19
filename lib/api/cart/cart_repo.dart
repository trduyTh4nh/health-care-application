import 'dart:developer';

import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/drug_cart_detail_model.dart';
import 'package:app_well_mate/model/drug_model.dart';
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
    try {
      Response res = await api.sendRequest.get("/cart/getAllDrugInCart/$id",
          options: Options(headers: header(token)));

      print("CON CACS");
      if (res.statusCode == 200) {
        print("Success");
        return "GetDataSuccess";
      } else {
        print("Fail");

        return "Fail";
      }
    } catch (ex) {
      print(ex);
      return "Faill nang roi";
    }
  }

  Future<List<DrugCartDetailModel>> getAllDrugInCartttt(int id) async {
    // print("DEBUG ID: " + id.toString());
    String token = await SecureStorage.getToken();
    // print("token cua user: $token");
    try {
      Response res = await api.sendRequest.get("/cart/getAllDrugInCart/$id",
          options: Options(headers: header(token)));
      var data = res.data['metadata']['listFiltered'];

      print("Body : ${data}");
      if (res.statusCode == 200) {
        final transformed = data as List<dynamic>;
        final dataFinal = transformed
            .map((item) => DrugCartDetailModel.fromJson(item))
            .toList();
        return dataFinal;
      } else {
        return [];
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> insertDrugToCart(DrugModel grug) async {
    String token = await SecureStorage.getToken();
    int idUser = await SecureStorage.getUserId();
    Map<String, dynamic> body = {
      'id_user': idUser,
      'id_drug': grug.idDrug,
    };
    try {
      Response res = await api.sendRequest.post('/cart/insertDrugIntoCart',
          data: body, options: Options(headers: header(token)));
      if (res.statusCode == 200) {
        return "Insert Success";
      } else {
        return "Insert Drug Into Cart Error";
      }
    } catch (ex) {
      print(ex);
      return "Error Drug into Cart";
    }
  }
}
