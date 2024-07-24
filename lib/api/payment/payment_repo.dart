import 'dart:developer';

import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/history_stransaction_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class PaymentRepo {
  API api = API();

  Future<bool> payment(
      id_address, id_user, total_price, listDrugCart, token, id_paypal) async {
    Map<String, dynamic> body = {
      'id_address': id_address,
      'id_user': id_user,
      'total_price': total_price,
      'listDrugCart': listDrugCart,
      'id_paypal': id_paypal
    };

    log(body.toString());

    Response res = await api.sendRequest.post('/payment/addPayment',
        options: Options(headers: header(token)), data: body);

    return res.statusCode == 200;
  }

  Future<List<HistoryStransactionModel>> getAllInvoices(
      {DateTime? date}) async {
    try {
      String token = await SecureStorage.getToken();
      int idUser = await SecureStorage.getUserId();

      final String baseUrl = '/payment/getAllInvoice/$idUser';
      final String url = date != null
          ? '$baseUrl?date=${DateFormat('yyyy-MM-dd').format(date)}'
          : baseUrl;

      Response res = await api.sendRequest.get(
        url,
        options: Options(headers: header(token)),
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> responseData = res.data;
        log('Response data: $responseData');

        if (responseData['metadata'] == null) {
          throw Exception('No data found');
        }

        List<dynamic> data = responseData['metadata'];
        List<HistoryStransactionModel> invoices = data
            .map((json) => HistoryStransactionModel.fromJson(json))
            .toList();

        if (date != null) {
          invoices = invoices.where((invoice) {
            DateTime invoiceDate = DateTime.parse(invoice.createDate as String);
            return invoiceDate.year == date.year &&
                invoiceDate.month == date.month &&
                invoiceDate.day == date.day;
          }).toList();
        }

        return invoices;
      } else {
        throw Exception('Failed to load Invoice');
      }
    } catch (ex) {
      print('Error: $ex');
      rethrow;
    }
  }
}
