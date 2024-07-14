import 'package:app_well_mate/model/drug_cart_model.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:flutter/material.dart';

class CartPageProvider extends ChangeNotifier {
  List<PrescriptionDetailModel> listDrugCart = [];

  void addDrugCart(PrescriptionDetailModel drug) {
    listDrugCart.add(drug);
    notifyListeners();
  }

  void deleteDrugCart(int index) {
    listDrugCart.removeAt(index);
    notifyListeners();
  }

  // int get countDrug {
  //   int cout = 0;

  // }
}
