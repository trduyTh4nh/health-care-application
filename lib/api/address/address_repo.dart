import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/address_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class AddressRepo {
  API api = API();

  Future<List<AddressModel>> getAddressByUserId(String token) async {
    try {
      List<AddressModel> addresses = [];
      int userId = await SecureStorage.getUserId();
      Response res = await api.sendRequest.get(
        '/address/allAddressUser/$userId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      var data = res.data['metadata'];
      if (data != null) {
        for (var element in data) {
          addresses.add(AddressModel.fromJson(element));
        }
      } else {
        log('No data received from server.');
      }
      return addresses;
    } on DioError catch (e) {
      if (e.response != null) {
        log('Error getting addresses: ${e.response!.statusCode} ${e.response!.data}');
      } else {
        log('Error getting addresses: ${e.message}');
      }
      return [];
    }
  }
  Future<bool> addAddress(String newAddress, String token) async{
    int userId = await SecureStorage.getUserId();
    Map<String, dynamic> body = {
      'id_user':userId,
      'address': newAddress,
    };
    Response res = await api.sendRequest.post('/address/addAddress',
          options: Options(headers: header(token)), data: body);
    print(newAddress);
    print(userId);
    return res.statusCode == 200;
  }
   Future<bool> UpdateAddress(int id_address, String newAddress, String token) async{
    
    Map<String, dynamic> body = {
      'id_address':id_address,
      'address': newAddress,
    };
    Response res = await api.sendRequest.put('/address/UpdateAddress',
          options: Options(headers: header(token)), data: body);
    print(id_address);
    print(newAddress);
    return res.statusCode == 200;
  }
  Future<void> deleteAddress(int id) async{
    try{
    String token = await SecureStorage.getToken();

      Response response = await api.sendRequest.delete('/address/deleteAddress/$id',
      options: Options(headers:header(token)));
      if(response.data['metadata']==1){
        print("delete success");

      }else{
        print("delete fail");
      }

    } catch (ex) {
     print(ex);
     rethrow;
    }
  }
}