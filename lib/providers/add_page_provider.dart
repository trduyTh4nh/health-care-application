import 'package:app_well_mate/api/application/application_repo.dart';
import 'package:app_well_mate/api/drug/drug_repo.dart';
import 'package:app_well_mate/const/functions.dart';
import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/hospital_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';
import 'package:flutter/material.dart';

class AddPageProvider extends ChangeNotifier {
  DrugRepo repo = DrugRepo();
  ApplicationRepo appRepo = ApplicationRepo();
  List<PrescriptionModel> _preList = [];
  List<PrescriptionModel> get preList => _preList;
  set preList(List<PrescriptionModel> newVal) {
    _preList = newVal;
    notifyListeners();
  }
  fetchApplication() async {
    _preList = (await appRepo.getPrescription()) ?? [];
  }
  TimeOfDay _startDate = TimeOfDay(hour: 6, minute: 0);
  TimeOfDay get startDate => _startDate;
  set startDate(TimeOfDay newVal) {
    _startDate = newVal;
    notifyListeners();
  }
  TimeOfDay _sDate = const TimeOfDay(hour: 1, minute: 0);
  TimeOfDay get sDate => _sDate;
  set sDate(TimeOfDay newVal) {
    if ((toSecond(_startDate) + ((_habit * toSecond(_sDate)) - 1)) / 3600 >
        24) {
      return;
    }
    _sDate = newVal;
    setCycle();
    notifyListeners();
  }

  void setCycle() {
    if (_habit != 0) {
      int time = toSecond(_startDate);
      _scheduleDetailModel = [];
      for (int i = 0; i < habit; i++) {
        if (i != 0) {
          time += toSecond(_sDate);
        }
        _scheduleDetailModel.add(ScheduleDetailModel(timeOfUse: toTime(time)));
      }
    }
  }
  
  List<DrugModel> _drugModelList = [];
  set drugModelList(List<DrugModel> newVal) {
    _drugModelList = newVal;
    notifyListeners();
  }
  List<DrugModel> get drugModelList => _drugModelList;
  fetchModelList() async {
    _drugModelList = (await repo.getAllDrug()) ?? [];
  }
  String searchQuery = "";
  searchDrug(String query) async {
    _drugModelList = (await repo.getAllDrugWithQuery(query)) ?? [];
  }
  List<ScheduleDetailModel?> _scheduleDetailModel = [];
  set scheduleDetailModel(List<ScheduleDetailModel?> newVal) {
    _scheduleDetailModel = newVal;
    notifyListeners();
  }
  void removeFromScheduleDetailModel(int index){
    _scheduleDetailModel.removeAt(index);
    _habit = 0;
    notifyListeners();
  }
  void addToScheduleDetailModel(ScheduleDetailModel? val) {
    if(val == null){
      return;
    }
    ScheduleDetailModel tmp = val;
    tmp.detail = _prescriptionDetail;
    tmp.status = "";
    _scheduleDetailModel.add(val);
    notifyListeners();
  }

  List<ScheduleDetailModel?> get scheduleDetailModel => _scheduleDetailModel;
  PrescriptionModel? _prescriptionModel;
  PrescriptionModel? get prescriptionModel => _prescriptionModel;
  set prescriptionModel(PrescriptionModel? newVal) {
    _prescriptionModel = newVal;
  }

  PrescriptionDetailModel? _prescriptionDetail =
      PrescriptionDetailModel(drug: DrugModel());
  PrescriptionDetailModel? get prescriptionDetail => _prescriptionDetail ?? PrescriptionDetailModel(drug: DrugModel());
  set prescriptionDetail(PrescriptionDetailModel? newVal) {
    _prescriptionDetail = newVal ?? PrescriptionDetailModel(drug: DrugModel());
    notifyListeners();
  }

  void addDrugToPrescriptionDetail(DrugModel model) {
    if (_prescriptionDetail == null) {
      return;
    }
    _prescriptionDetail!.drug = model;
    notifyListeners();
  }

  void addDetailToPrescription(PrescriptionDetailModel detail) {
    if (_prescriptionModel!.prescriptionDetails == null) {
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
  void checkIsDrugValid(){
    if(_prescriptionDetail != null){
      isValid = _prescriptionDetail!.quantity != null && _prescriptionDetail!.quantity! > 0 && _prescriptionDetail!.drug!.name != "";
    } else {
      isValid = false;
    }
  }
  //thói quen uống thuốc
  //> 0: lần / ngày
  //== 0: tự định nghĩa.
  int _habit = 1; //đơn vị lần/ngày.
  int get habit => _habit;
  set habit(int newVal) {
    _habit = newVal;
    _isValid = true;
    notifyListeners();
  }
}
