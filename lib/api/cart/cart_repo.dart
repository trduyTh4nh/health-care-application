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
      var data = res.data['metadata'];

      // log("Body : ${data}");
      if (res.statusCode == 200) {
        if ((data is! List)) {
          var filteredData = data['listFiltered'];
          final transformed = filteredData as List<dynamic>;
          final dataFinal = transformed
              .map((item) => DrugCartDetailModel.fromJson(item))
              .toList();
          return dataFinal;
        }
        return [];
      } else {
        return [];
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<int> insertDrugToCart(DrugModel grug, int idAppDetail) async {
    String token = await SecureStorage.getToken();
    int idUser = await SecureStorage.getUserId();
    Map<String, dynamic> body = {
      'id_user': idUser,
      'id_drug': grug.idDrug,
      'id_app_detail': idAppDetail
    };
    try {
      Response res = await api.sendRequest.post('/cart/insertDrugIntoCart',
          data: body, options: Options(headers: header(token)));
      if (res.statusCode == 200) {
        print("Insert Success");
        return res.statusCode!;
      } else {
        return 403;
      }
    } catch (ex) {
      print(ex);
      print("Error Drug into Cart");
      return 403;
    }
  }

  Future<String> updateQuantityCartDetail(
      int drugcartDetail, int quantity) async {
    String token = await SecureStorage.getToken();
    Map<String, dynamic> body = {
      'id_cart_detail': drugcartDetail,
      'quantity': quantity
    };
    try {
      Response res = await api.sendRequest.post(
          '/cart/updateQuantityCartDetail',
          data: body,
          options: Options(headers: header(token)));
      if (res.statusCode == 200) {
        print("status cua ham update: ${res.statusCode}");
        return "update success";
      } else {
        print("status cua ham update: ${res.statusCode}");
        return "update fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> deleteDrugFromCart(int id) async {
    String token = await SecureStorage.getToken();
    try {
      Response response = await api.sendRequest.delete(
          '/cart/deleteDrugInCart/$id',
          options: Options(headers: header(token)));
      if (response.data['metadata'] == 1) {
        print("status cua ham delete: ${response.statusCode}");
        return "delete success";
      } else {
        print("status cua ham delete: ${response.statusCode}");
        return "delete fail";
      }
    } catch (ex) {
      rethrow;
    }
  }
}
