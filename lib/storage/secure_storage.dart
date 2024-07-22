import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static AndroidOptions _getOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
  static final storage = FlutterSecureStorage(aOptions: _getOptions());
  static Future<bool> saveUser(String token, String user) async {
    try {
      await storage.write(key: "token", value: token);
      await storage.write(key: "user", value: user);
    } catch (ex) {
      return false;
    }
    return true;
  }
  static Future<String> getToken() async {
    String? token = await storage.read(key: "token");
    return token ?? "";
  }
  static Future<int> getUserId() async {
    String? user = await storage.read(key: "user");
    var userJson = jsonDecode(user ?? "");
    return int.parse(userJson["id_user"]);
  }
    static Future<int> getUserRole() async {
    String? user = await storage.read(key: "user");
    var userJson = jsonDecode(user ?? "");
    return userJson["role"];
  }
  static Future<String> getUserName() async {
    String? user = await storage.read(key: "user");
    var userJson = jsonDecode(user ?? "");
    return userJson["name"];
  }
}
