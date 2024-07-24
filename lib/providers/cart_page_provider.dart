import 'dart:developer';

import 'package:app_well_mate/api/cart/cart_repo.dart';
import 'package:app_well_mate/components/snack_bart.dart';
import 'package:app_well_mate/model/address_model.dart';
import 'package:app_well_mate/model/drug_cart_detail_model.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/storage/secure_storage.dart';
import 'package:flutter/material.dart';

class CartPageProvider extends ChangeNotifier {
  List<DrugCartDetailModel> listDrugCart = [];
  List<DrugCartDetailModel> listChecked = [];
  List<bool> _isChecked = [];
  AddressModel? selectedAddress;
  void setSelectedAddress(AddressModel address) {
    selectedAddress = address;
    notifyListeners();
  }

  void removeAddress() {
    selectedAddress = null;
  }

  List<bool> get isChecked => _isChecked;
  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  Future<void> fetchDrugCart() async {
    removeAddress();
    listChecked = [];
    _totalPrice = 0;
    int userId = await SecureStorage.getUserId();
    List<DrugCartDetailModel> items =
        await CartRepo().getAllDrugInCartttt(userId);
    listDrugCart = items;
    _isChecked = List<bool>.filled(listDrugCart.length, false);
    notifyListeners();
  }

  void removeCart() async {
    // final checkedSet = Set.from(listChecked);

    // final drugsToRemove =
    //     listDrugCart.where((drug) => checkedSet.contains(drug)).toList();

    // await Future.wait(drugsToRemove
    //     .map((drug) => CartRepo().deleteDrugFromCart(drug.idCart!)));
    for (var element in listChecked) {
      String result =
          await CartRepo().deleteDrugFromCart(element.idDrugCartDetail!);
      print("Đang remove ${element.drug!.name}");
      print("Day la ket qua: $result");
    }
    await fetchDrugCart();
    notifyListeners();
  }

  void deleteDrugCartFromCart(int id) async {
    print("id của thuốc bị xóa: $id");
    String result = await CartRepo().deleteDrugFromCart(id);
    await fetchDrugCart();
  }

  void addDrugtoCart(DrugModel drug, BuildContext context) async {
    int res = await CartRepo().insertDrugToCart(drug);
    if (res == 200) {
      log("Day la thuoc da duc them: ${drug.name}");
      fetchDrugCart();
    }
    if (res == 403) {
      log("item already exsists");
      showCustomSnackBar(context, "Đã có thuốc trong giỏ");
    }
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

  void toggleAllChecks() {
    bool newValue = !_isChecked.every((element) => element);
    _isChecked = List<bool>.filled(listDrugCart.length, newValue);
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
