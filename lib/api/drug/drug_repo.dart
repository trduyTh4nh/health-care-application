import 'dart:developer';

import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class DrugRepo {
  API api = API();
  Future<List<ScheduleDetailModel>> getSchedule() async {
    List<ScheduleDetailModel> lst = [];
    int userId = await SecureStorage.getUserId();
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.get("/drug/getAllDrugBy/$userId",
          options: Options(headers: header(token)));
      var data = res.data["metadata"];
      for (var e in data) {
        for (var e1 in e["drugAppDetailPromises"]) {
          for (var e2 in e1["scheduleDetail"]) {
            PrescriptionDetailModel? model =
                PrescriptionDetailModel.fromJson(e1);
            model.drug = DrugModel.fromJson(e1["drug"]);
            ScheduleDetailModel s = ScheduleDetailModel.fromJson(e2);
            s.detail = model;
            lst.add(s);
          }
        }
      }
      lst = lst
          .where((e) =>
              DateFormat("yyyy-MM-dd").format(e.lastConfirmed!) !=
              DateFormat("yyyy-MM-dd").format(DateTime.now()))
          .toList();
      log(lst.toString());
      return lst;
    } catch (ex) {
      log("error");
      log(ex.toString());
      return [];
    }
  }

  Future<PrescriptionDetailModel?> getDrugBy(int id) async {
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.get("/drug/getDrugFromDetail",
          data: {"id_app_detail": id},
          options: Options(headers: header(token)));
      final data = res.data["metadata"];
      PrescriptionDetailModel tmp = PrescriptionDetailModel.fromJson(data);
      tmp.drug = DrugModel.fromJson(data["drug"]);
      return tmp;
    } catch (ex) {
      log(ex.toString());
      return null;
    }
  }

  Future<List<ScheduleDetailModel>> getScheduleBy(int id) async {
    List<ScheduleDetailModel> lst = [];
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.get("/drug/getAllDrugAppBy/$id",
          options: Options(headers: header(token)));
      var data = res.data["metadata"];
      for (var e in data) {
        for (var e1 in e["drugAppDetailPromises"]) {
          for (var e2 in e1["scheduleDetail"]) {
            PrescriptionDetailModel? model =
                PrescriptionDetailModel.fromJson(e1);
            model.drug = DrugModel.fromJson(e1["drug"]);
            ScheduleDetailModel s = ScheduleDetailModel.fromJson(e2);
            s.detail = model;
            lst.add(s);
          }
        }
      }
      lst = lst
          .where((e) =>
              DateFormat("yyyy-MM-dd").format(e.lastConfirmed!) !=
              DateFormat("yyyy-MM-dd").format(DateTime.now()))
          .toList();
      return lst;
    } catch (ex) {
      log(ex.toString());
      return [];
    }
  }

  Future<List<ScheduleDetailModel>?> getPreDetail(int id) async {
    List<ScheduleDetailModel> lst = [];
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.get(
          "/drug/getAllApplicationDetail/$id",
          options: Options(headers: header(token)));
      final data = res.data["metadata"];
      for (var element in data) {
        ScheduleDetailModel tmp = ScheduleDetailModel();
        tmp.detail = PrescriptionDetailModel.fromJson(element);
        tmp.detail!.drug = DrugModel.fromJson(element["drug"]);
        lst.add(tmp);
      }
      //TODO: Filter ngày cuối cùng uống sau khi khứa thanh sửa
      return lst;
    } catch (ex) {
      log(ex.toString());
      return null;
    }
  }

  Future<String> deletePrescriptionDetail(int id) async {
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.delete(
          "/drug/deleteDrugFromDrugApplication",
          data: {"id_app_detail": id},
          options: Options(headers: header(token)));
      if (res.statusCode == 200) {
        log("SUCCESS! RESPONSE: ${res.data}");
        return res.data["message"].toString();
      }
      return "Lỗi máy chủ";
    } catch (ex) {
      log("ERROR!: $ex");
      if (ex is DioException) {
        DioException excep = ex;
        log("ERROR!: $ex");
        log("RESPONSE: ${excep.response}");
        return excep.response!.data["code"].toString();
      }
      return "Lỗi vô định";
    }
  }

  Future<List<DrugModel>?> getAllDrug() async {
    String token = await SecureStorage.getToken();
    try {
      List<DrugModel> lst = [];
      Response res = await api.sendRequest.get("/drug/getAllDrugSystem",
          options: Options(headers: header(token)));
      var data = res.data["metadata"];
      if (data is List) {
        lst = data.map((e) => DrugModel.fromJson(e)).toList();
      }
      return lst;
    } catch (ex) {
      log(ex.toString());
      return null;
    }
  }

  Future<List<DrugModel>?> getAllDrugWithQuery(String query) async {
    String token = await SecureStorage.getToken();
    try {
      List<DrugModel> lst = [];
      Response res = await api.sendRequest.get(
          "/drug/searchDrug?searchText=$query",
          options: Options(headers: header(token)));
      var data = res.data["metadata"];
      if (data is List) {
        lst = data.map((e) => DrugModel.fromJson(e)).toList();
      }
      log(lst.toString());
      return lst;
    } catch (ex) {
      log(ex.toString());
      return null;
    }
  }

  Future<int> updateSchedule(int id) async {
    String token = await SecureStorage.getToken();
    int idUser = await SecureStorage.getUserId();
    try {
      Response res = await api.sendRequest.put(
          "/schedule/updateScheduleDetail/$id",
          data: {"id_user": idUser},
          options: Options(headers: header(token)));
      return res.data["metadata"][0];
    } catch (ex) {
      log(ex.toString());
      return 0;
    }
  }

  Future<List<ScheduleDetailModel>?> getLog() async {
    String token = await SecureStorage.getToken();
    int idUser = await SecureStorage.getUserId();
    List<ScheduleDetailModel> lst = [];
    try {
      Response res = await api.sendRequest.get("/log/getAllLogs/$idUser",
          data: {"id_user": idUser}, options: Options(headers: header(token)));
      var data = res.data["metadata"];
      if (data is List) {
        lst = data.map((e) {
          ScheduleDetailModel tmp =
              ScheduleDetailModel.fromJson(e["scheduleDetail"]);
          tmp.status = "Completed";
          tmp.detail = PrescriptionDetailModel.fromJson(
              e["scheduleDetail"]["drugAppDetail"]);
          tmp.detail!.drug =
              DrugModel.fromJson(e["scheduleDetail"]["drugAppDetail"]["drug"]);
          return tmp;
        }).toList();
      }
      return lst;
    } catch (ex) {
      log(ex.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>?> addDrugToApp(Map<String, dynamic> data) async {
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.post("/drug/addDrugCustom",
          data: data, options: Options(headers: header(token)));
      var dataRes = res.data["metadata"];
      return dataRes;
    } catch (ex) {
      log(ex.toString());
      return null;
    }
  }
}
