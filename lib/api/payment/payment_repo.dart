import 'dart:developer';

import 'package:app_well_mate/api/api.dart';
import 'package:dio/dio.dart';

class PaymentRepo {
  API api = API();

  Future<bool> payment(
      id_address, id_user, total_price, listDrugCart, token) async {
    Map<String, dynamic> body = {
      'id_address': id_address,
      'id_user': id_user,
      'total_price': total_price,
      'listDrugCart': listDrugCart,
    };

    log(body.toString());

    Response res = await api.sendRequest.post('/payment/addPayment',
        options: Options(headers: header(token)), data: body);

    return res.statusCode == 200;
  }
}
