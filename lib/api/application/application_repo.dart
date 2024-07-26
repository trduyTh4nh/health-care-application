import 'dart:developer';

import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';

class ApplicationRepo {
  API api = API();
  Future<List<PrescriptionModel>?> getPrescription() async {
    List<PrescriptionModel> lst = [];
    int idUser = await SecureStorage.getUserId();
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.get(
          "/drug/getAllApplication/$idUser",
          options: Options(headers: header(token)));
      final data = res.data["metadata"];
      for (var element in data) {
        lst.add(PrescriptionModel.fromJson(element));
      }
      return lst;
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  Future<int> scanApplication(int id) async {
    int idUser = await SecureStorage.getUserId();
    String token = await SecureStorage.getToken();
    log(id.toString());
    try {
      Response res = await api.sendRequest.put("/drug/scan",
          data: {"id_user": idUser, "id_application": id},
          options: Options(headers: header(token)));
      log(res.data.toString());
      if (res.statusCode == 200) {
        return 1;
      }
      return 0;
    } catch (ex) {
      if (ex is DioException) {
        DioException excep = ex;
        String s = ex.response!.data["message"].toString();
        if (s == "You does not have permission!") {
          return -1;
        }
        return -2;
      }
      log(ex.toString());
      return 0;
    }
  }

  Future<PrescriptionModel> getApplicationBy(int id) async {
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.get("/drug/getAppendHospital/$id",
          options: Options(headers: header(token)));
      final data = res.data["metadata"];
      log(data.toString());
      return PrescriptionModel.fromJson(data);
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  Future<String> getBestDisease(int month) async {
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.get("/user/getBestDisease",
          data: {"month": month}, options: Options(headers: header(token)));
      final data = res.data["metadata"];
      if(data is List){
        if(data.isEmpty){
          return "";
        }
      }
      return data["disease"]["disease_name"];
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  //Ham lay thuoc cua tung user
  Future<List<PrescriptionModel>?> getPrescriptionInUser(int idUser) async {
    List<PrescriptionModel> lst = [];
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.get(
          "/drug/getAllApplication/$idUser",
          options: Options(headers: header(token)));
      final data = res.data["metadata"];
      for (var element in data) {
        lst.add(PrescriptionModel.fromJson(element));
      }
      return lst;
    } catch (ex) {
      log(ex.toString());
      return null;
    }
  }
}
