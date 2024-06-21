import 'dart:math';

import 'package:app_well_mate/model/drug_model.dart';
import 'package:app_well_mate/model/schedule_detail_model.dart';

// fake API fetch

//GET
// tìm thuốc thông qua id thuốc của đơn thuốc chi tiết
DrugModel? findDrugByIdPrescriptionDetail(int idDrug) {
  List<DrugModel> listDrug = generateSampleDrugs();

  try {
    DrugModel result = listDrug.firstWhere((drug) => drug.idDrug == idDrug);
    return result;
  } catch (e) {
    return null;
  }
}

//GET
List<ScheduleDetailModel>? findScheduleDetail(int idPre) {
  try {
    List<ScheduleDetailModel> result = generateSampleScheduleDetails();
    return result.where((childSche) => childSche.idPreDetail == idPre).toList();
  } catch (e) {
    return null;
  }
}
