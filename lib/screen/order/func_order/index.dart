import 'dart:developer';

import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/order_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/prescription_model.dart';

// [GET]
OrderModel? findOrderById(int idOrder) {
  // fetch
  List<OrderModel> orders = generateSampleOrders();
  try {
    return orders.firstWhere((order) => order.idOrder == idOrder);
  } catch (e) {
    log(e.toString());
    return null;
  }
}

// [GET]
PrescriptionModel? findPrescriptionByIdFromOrder(int idPrescription) {
  print(idPrescription);
  // fetch
  List<PrescriptionModel> prescriptions = generateSamplePrescriptions();
  try {
    return prescriptions.firstWhere((pre) => pre.idPre == idPrescription);
  } catch (error) {
    print(error);
    return null;
  }
}

// [GET]
List<DrugModel>? getListDrug(List<PrescriptionDetailModel> list) {
  List<DrugModel> result = [];
  try {
    for (var preDetail in list) {
      // fetch list drug
      List<DrugModel> data = generateSampleDrugs();
      DrugModel drugElement =
          data.firstWhere((e) => e.idDrug == preDetail.idDrug);
      result.add(drugElement);
    }
    return result;
  } catch (error) {
    return null;
  }
}
