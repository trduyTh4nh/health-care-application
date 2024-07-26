import 'dart:convert';
import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/disease.dart';
import 'package:app_well_mate/model/diseaseOfYear.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';

class DiseaseAdminRepo {
  API api = API();

  Future<List<Diseaseofyear>> getNumDiseaseOfYear(int id_disease, int year) async{
    Map<String, dynamic> body = {
      'id_disease': id_disease,
      'year': year,
    };
    try{
      String token = await SecureStorage.getToken();
      String adminToken = "FBZwFdSI9KOxUGkN4IKaOwwUMnTgX4i2dTcWCgo3wxSTXvKs162";
      Response response = await api.sendRequest.get(
        "/user/getNumberDiseaseOfYear",data: body,
        options: Options(headers: adminHeader(token, adminToken)),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        print("Response data: $responseData");
        if (responseData['metadata'] == null) {
          throw Exception('No data found');
        }
        List<dynamic> data = responseData['metadata'];
        return data.map((json) => Diseaseofyear.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load disease');
      }
    }catch(ex){
      print("Error get all disease $ex");
      rethrow;
    }
  }

  
  Future<List<Disease>> getAllDisease() async {
    try {
      String token = await SecureStorage.getToken();
      //chua them body
      
      String adminToken = "FBZwFdSI9KOxUGkN4IKaOwwUMnTgX4i2dTcWCgo3wxSTXvKs162";
      Response response = await api.sendRequest.get(
        "/user/getAllDisease",
        
        options: Options(headers: adminHeader(token, adminToken)),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        print("Response data: $responseData");

        if (responseData['metadata'] == null) {
          throw Exception('No data found');
        }
        List<dynamic> data = responseData['metadata'];
        return data.map((json) => Disease.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load disease');
      }
    } catch (ex) {
      print("Error get all disease $ex");
      rethrow;
    }
  }

  Future<List<String>> getDiseaseNames() async {
    try {
      List<Disease> diseases = await getAllDisease();
      return diseases
          .map((disease) => disease.disease_name)
          .where((name) => name != null)
          .cast<String>()
          .toList();
    } catch (ex) {
      print("Error getting disease names: $ex");
      return [];
    }
  }
}
