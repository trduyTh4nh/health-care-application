import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/notification_model.dart';
import 'package:app_well_mate/screen/search/component_crawl.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';

class NotificationRepo {
  API api = API();
  Future<int> insertNotification(Map<String, dynamic> notif) async {
    String token = await SecureStorage.getToken();
    try{
      Response res = await api.sendRequest.post("/notification/createNotification", data: notif, options: Options(headers: header(token)));
      if(res.statusCode == 200){
        return 1;
      }
      return 0;
    } on DioException catch (ex) {
      log(ex);
      rethrow;
    }
  }
  Future<List<NotificationModel>?> getNotifications() async {
    String token = await SecureStorage.getToken();
    int idUser = await SecureStorage.getUserId();
    List<NotificationModel> lst = [];
    try{
      Response res = await api.sendRequest.get("/notification/getAllNotification/$idUser", options: Options(headers: header(token)));
      final data = res.data["metadata"];
      log(data.toString());
      if(data is List){
        lst = data.map((e) => NotificationModel.fromJson(e)).toList();
      }
      if(res.statusCode == 200){
        return lst;
      }
      return null;
    } on DioException catch (ex) {
      log(ex);
      rethrow;
    }
  }
}