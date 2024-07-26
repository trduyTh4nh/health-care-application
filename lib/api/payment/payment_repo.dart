import 'dart:developer';

import 'package:app_well_mate/api/api.dart';
import 'package:app_well_mate/model/address_model.dart';
import 'package:app_well_mate/model/drug_cart_detail_model.dart';
import 'package:app_well_mate/model/history_stransaction_model.dart';
import 'package:app_well_mate/model/invoice_detail_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class PaymentRepo {
  API api = API();

  Future<int?> payment(
      id_address, id_user, total_price, listDrugCart, token, id_paypal) async {
    for (var element in listDrugCart) {
      log(element["id_app_detail"].toString());
    }
    Map<String, dynamic> body = {
      'id_address': id_address,
      'id_user': id_user,
      'total_price': total_price,
      'listDrugCart': listDrugCart,
      'id_paypal': id_paypal,
    };
    log(body.toString());
    Response res = await api.sendRequest.post('/payment/addPayment',
        options: Options(headers: header(token)), data: body);
    log(res.data["metadata"][["id_invoice"]].toString());
    return res.statusCode == 200 ? res.data["metadata"]["id_invoice"] : -1;
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
        if (responseData['metadata'] == null) {
          throw Exception('No data found');
        }
        List<dynamic> data = responseData['metadata'];
        List<HistoryStransactionModel> invoices = data.map((json) {
          HistoryStransactionModel model =
              HistoryStransactionModel.fromJson(json);
          return model;
        }).toList();
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

  Future<HistoryStransactionModel> getAllInvoiceDetailBy(int id) async {
    String token = await SecureStorage.getToken();
    List<InvoiceDetailModel> lst = [];
    try {
      Response res = await api.sendRequest.get("/payment/getInvoice/$id",
          options: Options(headers: header(token)));
      final data = res.data["metadata"];
      HistoryStransactionModel model = HistoryStransactionModel.fromJson(data);
      model.address = AddressModel.fromJson(data["addressFounded"]);
      final listDetail = data["listResult"];
      log(listDetail.toString());
      if (listDetail is List) {
        lst = listDetail
            .map((e) => InvoiceDetailModel.fromSeperateJson(
                e["invoiceDetail"], e["drug"]))
            .toList();
        model.listInvoiceDetail = lst;
      }
      return model;
    } catch (ex) {
      if (ex is TypeError) {
        log("Lấy stacktrace ra cho thầy: ${ex.stackTrace}");
      }
      log(ex.toString());
      rethrow;
    }
  }

  Future<bool> destroyInvoice(int id) async {
    String token = await SecureStorage.getToken();
    try {
      Response res = await api.sendRequest.put("/payment/updateDestroyInvoice",
          data: {"id_invoice": id}, options: Options(headers: header(token)));
      return res.statusCode == 200;
    } catch (ex) {
      log(ex.toString());
      rethrow;
    }
  }

  Future<List<HistoryStransactionModel>> getAllInvoicesBy(
      {DateTime? date}) async {
    try {
      String token = await SecureStorage.getToken();
      int idUser = await SecureStorage.getUserId();

      final String baseUrl = '/payment/getAllOrder/$idUser';
      final String url = date != null
          ? '$baseUrl?date=${DateFormat('yyyy-MM-dd').format(date)}'
          : baseUrl;

      Response res = await api.sendRequest.get(
        url,
        options: Options(headers: header(token)),
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> responseData = res.data;
        if (responseData['metadata'] == null) {
          throw Exception('No data found');
        }
        final data = responseData['metadata'];
        List<HistoryStransactionModel> invoices = [];

        if (data is List) {
          invoices = data.map((json) {
            final data = json["listInvoiceDetail"];
            HistoryStransactionModel model =
                HistoryStransactionModel.fromJson(json);
            model.address = AddressModel.fromJson(json["address"]);
            if (data is List) {
              model.countDrug = data.length;
            }
            return model;
          }).toList();
        }
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
      log('Error: $ex');
      rethrow;
    }
  }
}
