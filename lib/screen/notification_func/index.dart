import 'package:app_well_mate/model/hospital_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/prescription_model.dart';

//[GET]
PrescriptionDetailModel? getPrescriptionModelDetailFromId(int preDetail) {
  List<PrescriptionDetailModel> _listPreDetailModel = generateSamplePrescriptionDetails();
  try {
    print("Debug preid: ${preDetail}");
    for (var element in _listPreDetailModel) {
        print(element.idPreDetail);
    }
    PrescriptionDetailModel preDetailModel = _listPreDetailModel.firstWhere(
      (element) => element.idPreDetail == preDetail,
      orElse: () => throw Exception('No element found'),
    );
    return preDetailModel;
  } catch (e) {
    print("Error: $e");
    return null;
  }
}




// [GET]
PrescriptionModel? getPrescriptionModel(int preId) {
  List<PrescriptionModel> _listPreModel = generateSamplePrescriptions();
  try {
    PrescriptionModel pre = _listPreModel
        .firstWhere((element) => element.idPre == preId,
        orElse: () => throw Exception('No element found 1'),);
    print(pre.hospital!.name);
    return pre;
  } catch (e) {
    print("Error: $e");
    return null;
  }
}


//[GET]
HospitalModel? getHospital(int idHospital) {
  List<HospitalModel> _listHospital = generateSampleHospital();
  try {
    HospitalModel hos =
        _listHospital.firstWhere((hospital) => hospital.idHospital == idHospital)
            as HospitalModel;
    return hos;
  } catch (e) {
    return null;
  }
}
