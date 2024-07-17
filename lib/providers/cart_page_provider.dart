import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:flutter/material.dart';

class CartPageProvider extends ChangeNotifier {
  List<PrescriptionDetailModel> listDrugCart = [];
  Set<int> selectedItems = {};  // này để lưu trạng thái được chọn

  void addDrugCart(PrescriptionDetailModel drug) {
    listDrugCart.add(drug);
    notifyListeners();
  }

  void deleteDrugCart(int index) {
    listDrugCart.removeAt(index);
    notifyListeners();
  }

  void toggleSelection(int index) {
    if (selectedItems.contains(index)) {
      selectedItems.remove(index);
    } else {
      selectedItems.add(index);
    }
    notifyListeners();
  }

  void selectAll() {
    selectedItems = {for (int i = 0; i < listDrugCart.length; i++) i};
    notifyListeners();
  }

  void deselectAll() {
    selectedItems.clear();
    notifyListeners();
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (int index in selectedItems) {
      var item = listDrugCart[index];
      totalPrice += (item.drug!.price ?? 0) * (item.quantity ?? 1);
    }
    return totalPrice;
  }
   List<PrescriptionDetailModel> getSelectedDrugs() {
    return selectedItems.map((index) => listDrugCart[index]).toList();
  }
}
