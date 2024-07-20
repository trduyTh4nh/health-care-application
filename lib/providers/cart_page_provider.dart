import 'package:app_well_mate/api/cart/cart_repo.dart';
import 'package:app_well_mate/model/drug_cart_detail_model.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:flutter/material.dart';

class CartPageProvider extends ChangeNotifier {
  List<DrugCartDetailModel> listDrugCart = [];
  List<DrugCartDetailModel> listChecked = [];
  List<bool> _isChecked = [];

  List<bool> get isChecked => _isChecked;
  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  Future<void> fetchDrugCart() async {
    int userId = await SecureStorage.getUserId();
    List<DrugCartDetailModel> items =
        await CartRepo().getAllDrugInCartttt(userId);
    listDrugCart = items;
    _isChecked = List<bool>.filled(listDrugCart.length, false);
    notifyListeners();
  }

  void addDrugtoCart(DrugModel drug) async {
    await CartRepo().insertDrugToCart(drug);
    print("Day la thuoc da duc them: ${drug.name}");
    // await fetchDrugCart();
    fetchDrugCart();
  }

  void deleteDrugCartFromCart(int id) async {
    print("id của thuốc bị xóa: $id");
    String result = await CartRepo().deleteDrugFromCart(id);
    await fetchDrugCart();
  }

  void updateQuantityDetial(int drugcartDetail, int quantity) async {
    String result =
        await CartRepo().updateQuantityCartDetail(drugcartDetail, quantity);
    print(result);
    await fetchDrugCart();
  }

  void toggleCheck(int index) {
    _isChecked[index] = !_isChecked[index];
    calculateTotalPrice();
    listDrugChecked();
  }

  void calculateTotalPrice() {
    _totalPrice = 0.0;
    for (int i = 0; i < listDrugCart.length; i++) {
      if (_isChecked[i]) {
        _totalPrice += listDrugCart[i].drug!.price! * listDrugCart[i].quantity!;
      }
    }
  }

  void listDrugChecked() {
    listChecked = [];
    for (int i = 0; i < listDrugCart.length; i++) {
      if (_isChecked[i]) {
        listChecked.add(listDrugCart[i]);
      }
    }
    notifyListeners();
  }
}
