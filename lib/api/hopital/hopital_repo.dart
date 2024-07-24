import 'dart:convert';
import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/hospital_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HospitalRepo {
  API api = API();
  
  Future<List<HospitalModel>> getAllHospitals() async {
    try {
      String token = await SecureStorage.getToken();
      String adminToken = "FBZwFdSI9KOxUGkN4IKaOwwUMnTgX4i2dTcWCgo3wxSTXvKs162";
      Response response = await api.sendRequest.get(
        '/drug/getAllHospital',
        options: Options(headers: adminHeader(token, adminToken)),
      );
      
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data['metadata'];
        return responseData.map((json) => HospitalModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load hospitals');
      }
    } catch (ex) {
      debugPrint("Error fetching hospitals: $ex");
      rethrow;
    }
  }
}
