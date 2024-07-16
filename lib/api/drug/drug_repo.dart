import 'dart:developer';

import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';

class DrugRepo {
  API api = API();
  Future<List<ScheduleDetailModel>> getSchedule() async {
    List<ScheduleDetailModel> lst = [];
    int userId = await SecureStorage.getUserId();
    String token = await SecureStorage.getToken();
    Response res = await api.sendRequest.get("/drug/getAllDrugBy/$userId",
        options: Options(headers: header(token)));
    var data = res.data["metadata"];
    for (var e in data) {
      for (var e1 in e["drugAppDetailPromises"]) {
        for (var e2 in e1["scheduleDetail"]) {
          PrescriptionDetailModel? model = PrescriptionDetailModel.fromJson(e1);
          model.drug = DrugModel.fromJson(e1["drug"]);
          ScheduleDetailModel s = ScheduleDetailModel.fromJson(e2);
          s.detail = model;
          lst.add(s);
        }
      }
    }
    return lst;
  }
}
