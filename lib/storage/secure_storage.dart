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
}
