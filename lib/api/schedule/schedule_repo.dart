import 'dart:developer';

import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';

class ScheduleRepo {
  API api = API();
  Future<List<ScheduleDetailModel>?> findAllSchedulesBy(int id) async {
    String token = await SecureStorage.getToken();
    List<ScheduleDetailModel> schedules = [];
    try {
      Response res = await api.sendRequest.get(
          "/schedule/getAllScheduleDetailFromIdDrugDetail/$id",
          options: Options(headers: header(token)));
      var data = res.data["metadata"];
      for (var element in data) {
        schedules.add(ScheduleDetailModel.fromJson(element));
      }
      return schedules;
    } catch (ex) {
      log(ex.toString());
      return null;
    }
  }

  Future<String> deleteScheduleBy(int id) async {
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.delete(
          "/schedule/deleteScheduleDetail/$id",
          options: Options(headers: header(token)));
      var data = res.data["message"].toString();
      log(data.toString());
      return data;
    } catch (ex) {
      log(ex.toString());
      if (ex is DioException) {
        return "ex";
      }
      return "Fail hard";
    }
  }
}
