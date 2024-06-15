import 'package:flutter/material.dart';

class AddPageProvider extends ChangeNotifier {
  //TODO: Implement change after model.
  bool _isValid = false;
  bool get isValid => _isValid;
  set isValid(bool newVal) {
    _isValid = newVal;
    notifyListeners();
  }
  //thói quen uống thuốc
  //> 0: lần / ngày
  //== 0: tự định nghĩa.
  int _habit = 1; //đơn vị lần/ngày.
  int get habit => _habit;
  set habit(int newVal) {
    _habit = newVal;
    notifyListeners();
  }
}