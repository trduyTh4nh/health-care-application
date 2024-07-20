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
      return null;
    }
  }
}
