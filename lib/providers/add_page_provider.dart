import 'dart:developer';

import 'package:app_well_mate/const/functions.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/hospital_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:flutter/material.dart';

class AddPageProvider extends ChangeNotifier {
  TimeOfDay _startDate = TimeOfDay(hour: 6, minute: 0);
  TimeOfDay get startDate => _startDate;
  set startDate(TimeOfDay newVal){
    _startDate = newVal;
    notifyListeners();
  }
  TimeOfDay _sDate = TimeOfDay(hour: 1, minute: 0);
  TimeOfDay get sDate => _sDate;
  set sDate(TimeOfDay newVal){
    if((toSecond(_startDate) + ((_habit * toSecond(_sDate)) - 1)) / 3600 > 24){
      return;
    }
    for(int i = 0; i < habit; i++){
      int time = toSecond(_startDate);
      time += toSecond(_startDate) + toSecond(_sDate);
      _scheduleDetailModel.add(ScheduleDetailModel(time: toTime(time)));
    }
    _sDate = newVal;
    notifyListeners();
  }
  List<ScheduleDetailModel?> _scheduleDetailModel = [];
  set scheduleDetailModel(List<ScheduleDetailModel?> newVal){
    _scheduleDetailModel = newVal;
    notifyListeners();
  }
  void addToScheduleDetailModel(ScheduleDetailModel? val){
    _scheduleDetailModel.add(val);
    notifyListeners();
  }
  List<ScheduleDetailModel?> get scheduleDetailModel => _scheduleDetailModel;
  PrescriptionModel? _prescriptionModel = PrescriptionModel(idPre: 0, idUser: 0, idHospital: 0, createdDate: DateTime.now(), doctorName: "Tiêu Trí Quang", status: "", prescriptionDetails: [], hospital: HospitalModel(address: "Quận 10", name: "Bệnh viện example", createdDate: DateTime.now()));
  PrescriptionModel? get prescriptionModel => _prescriptionModel;
  set prescriptionModel(PrescriptionModel? newVal) {
    prescriptionModel = newVal;
  }
  PrescriptionDetailModel? _prescriptionDetail = PrescriptionDetailModel(drug: DrugModel());
  PrescriptionDetailModel? get prescriptionDetail => _prescriptionDetail;
  set prescriptionDetail(PrescriptionDetailModel? newVal){
    _prescriptionDetail = newVal;
    notifyListeners();
  }
  void addDrugToPrescriptionDetail(DrugModel model){
    if(_prescriptionDetail == null){  
      return;
    }
    _prescriptionDetail!.drug = model;
    notifyListeners();
  }
  void addDetailToPrescription(PrescriptionDetailModel detail){
    if(_prescriptionModel!.prescriptionDetails == null){
      _prescriptionModel!.prescriptionDetails = [];
    }
    _prescriptionModel!.prescriptionDetails!.add(detail);
    notifyListeners();
  }
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