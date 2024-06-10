class Disease {
  int? id;
  String? doctor;
  String? title;
  String? description;
  DateTime? time;
  String? overview;
  List<DiseaseDetail>? details;

  Disease(
      {this.id,
      this.doctor,
      this.title,
      this.description,
      this.time,
      this.overview,
      this.details});
}

class DiseaseDetail {
  int? idDetail;
  String? titleDetail;
  String? contentDetail;
  String? imageDetail;

  DiseaseDetail(
      {this.idDetail, this.titleDetail, this.contentDetail, this.imageDetail});
}

List<DiseaseDetail> diseaseArr = [
  DiseaseDetail(
      idDetail: 1,
      titleDetail: 'Detail 1',
      contentDetail: 'Content detail 1',
      imageDetail: 'Image detail 1'),
  DiseaseDetail(
      idDetail: 2,
      titleDetail: 'Detail 2',
      contentDetail: 'Content detail 2',
      imageDetail: 'Image detail 2')
];

Disease disease = Disease(
    id: 1,
    doctor: 'Mr. Smith',
    title: 'Titlte for disease',
    description: 'Description for disease',
    time: DateTime.now(),
    overview: 'Overview of disease',
    details: diseaseArr);
