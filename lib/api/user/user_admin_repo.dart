import 'dart:developer'; // Đảm bảo import đúng thư viện log
import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/user.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';

class ManagementUserAdminRepo {
  API api = API();

  Future<List<User>> getAllUser() async {
    try {
      String token = await SecureStorage.getToken();
      String adminToken = "FBZwFdSI9KOxUGkN4IKaOwwUMnTgX4i2dTcWCgo3wxSTXvKs162";
      Response res = await api.sendRequest.get(
        '/user/getAllUser',
        options: Options(headers: adminHeader(token, adminToken)),
      );
      if (res.statusCode == 200) {
        Map<String, dynamic> responseData = res.data;
        log('Response data: $responseData');

        if (responseData['metadata'] == null) {
          throw Exception('No data found');
        }
        List<dynamic> data = responseData['metadata'];
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (ex) {
      print("Error get all user $ex");
      rethrow;
    }
  }
}
