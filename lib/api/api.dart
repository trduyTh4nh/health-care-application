import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class API {
  final Dio _dio = Dio();
  String? baseUrl;

  API() {
    baseUrl = dotenv.env["API_URL"];
    _dio.options.baseUrl = "$baseUrl/v1/api";
    _dio.options.connectTimeout = const Duration(minutes: 1);
  }

  Dio get sendRequest => _dio;
}
Map<String, dynamic> header(String token) {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token',
    };
  }