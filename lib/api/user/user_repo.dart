import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';

class UserRepo{
  API api = API();
  Future<bool> changePassword(String newPassword, String token) async {
    int userId = await SecureStorage.getUserId();
    Map<String, dynamic> body = {
      'id_user': userId,
      'repass': newPassword,
    };

    try {
      Response response = await api.sendRequest.put(
        '/user/changePassword',
        options: Options(headers: header(token)),
        data: body,
      );

      if (response.statusCode == 200) {
        print(userId);
        print(newPassword);
        return true;
        
      } else {
        return false;
      }
    } catch (e) {
      print("Cứu thầyyy: $e");
      return false;
    }
  }
  // Future<bool> changePassword(String newPassword, String token)async{
  //   int userId = await SecureStorage.getUserId();
  //   Map<String, dynamic> body = {
  //     'id_user':userId,
  //     'repass':newPassword,
  //   };
  //   Response response = await api.sendRequest.put('/user/changePassword',
  //   options: Options(headers: header(token)), data: body);
  //   print(newPassword);
  //   print(userId);
  //   return response.statusCode == 200;
  // }
}