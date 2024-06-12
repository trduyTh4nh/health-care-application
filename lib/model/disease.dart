class Disease {
  int? id;
  String? doctor;
  String? title;
  String? description;
  DateTime? time;
  String? overview;
  List<DiseaseDetail>? details;
  String? reason;

  Disease(
      {this.id,
      this.doctor,
      this.title,
      this.description,
      this.time,
      this.overview,
      this.details,
      this.reason});
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
      titleDetail: 'Giai đoạn IIA (T3, N0, M0)',
      contentDetail:
          'Khối u đã phát triển xuyên qua lớp cơ và vào lớp thanh mạc nhưng chưa xuyên qua nó. Khối u chưa lan đến các mô và các hạch bạch huyết lân cận.',
      imageDetail:
          'https://cdn.youmed.vn/tin-tuc/wp-content/uploads/2023/08/Ung-thu-dai-trang-giai-doan-2-1-768x459.jpg'),
  DiseaseDetail(
      idDetail: 2,
      titleDetail: 'Giai đoạn IIB (T4a, N0, M0)',
      contentDetail:
          'Khối u đã phát triển xuyên qua các lớp cơ đến phúc mạc. Tức là nó đã xuyên qua các lớp của đại tràng (gồm niêm mạc, dưới niêm mạc, cơ, thanh mạc – tính từ trong ra ngoài). Tuy nhiên, khối u vẫn chưa lan đến các mô và các hạch bạch huyết gần đó.',
      imageDetail:
          'https://cdn.youmed.vn/tin-tuc/wp-content/uploads/2023/08/Ung-thu-dai-trang-giai-doan-2-2-768x463.jpg'),
  DiseaseDetail(
      idDetail: 3,
      titleDetail: 'Giai đoạn IIC (T4b, N0, M0)',
      contentDetail:
          'Khối u đã xuyên qua thành đại tràng, phát triển và gắn vào các cơ quan, cấu trúc lân cận. Khối u vẫn chưa lan đến các hạch bạch huyết lân cận hoặc di căn xa.',
      imageDetail:
          'https://cdn.youmed.vn/tin-tuc/wp-content/uploads/2023/08/Ung-thu-dai-trang-giai-doan-2-3-768x460.jpg')
];

List<DiseaseDetail> diseaseArr2 = [
  DiseaseDetail(
      idDetail: 1,
      titleDetail: 'Detail 1',
      contentDetail: 'Content detail 1',
      imageDetail: 'Image detail 1'),
  DiseaseDetail(
      idDetail: 2,
      titleDetail: 'Detail 2',
      contentDetail: 'Content detail 2',
      imageDetail: 'Image detail 2'),
  DiseaseDetail(
      idDetail: 3,
      titleDetail: 'Detail 3',
      contentDetail: 'Content detail 3',
      imageDetail: 'Image detail 3')
];

List<Disease> allDisease = [
  Disease(
      id: 1,
      doctor: 'ThS.BS.CKI Phan Lương Huy',
      title: 'Cancer',
      description:
          'Ở giai đoạn 2 của ung thư đại tràng, khối u vẫn chưa lan ra đến các hạch bạch huyết lân cận hoặc di căn xa. Vì vậy nếu phát hiện sớm thì vẫn có cơ hội để kiểm soát và chữa khỏi hoàn toàn. Bên cạnh phát hiện sớm ung thư đại tràng, các yếu tố như độ tuổi, lựa chọn điều trị, thể trạng người bệnh cũng như mức độ đáp ứng điều trị cũng ảnh hưởng đến kết quả điều trị.',
      time: DateTime.now(),
      overview:
          'Ung thư màng phổi là gì? U trung biểu mô (mesothelioma) là ung thư xảy ra ở các lớp màng mỏng bao bọc các cơ quan trong cơ thể, bao gồm lớp biểu mô màng bụng, màng ngoài tim và màng phổi, vốn có nguồn gốc phôi thai từ trung bì phổi. Trong các vị trí trên, ung thư trung biểu mô xảy ra chủ yếu ở màng phổi. Ung thư trung biểu mô màng phổi (maglinant pleural mesothelioma) cũng là loại ung thư duy nhất của màng phổi được biết đến',
      details: diseaseArr,
      reason: "1. Một số loại thực phẩm có chứa nitrat. \n"
          "2. Thay đổi giấc ngủ hoặc thiếu ngủ. \n"
          "3. Tư thế xấu. \n"
          "4. Bỏ bữa. \n"
          "5. Căng thẳng. \n"),
  Disease(
      id: 1,
      doctor: 'ThS.BS.CKI Phan Lương Huy',
      title: 'Cancer 2',
      description:
          'Ở giai đoạn 2 của ung thư đại tràng, khối u vẫn chưa lan ra đến các hạch bạch huyết lân cận hoặc di căn xa. Vì vậy nếu phát hiện sớm thì vẫn có cơ hội để kiểm soát và chữa khỏi hoàn toàn. Bên cạnh phát hiện sớm ung thư đại tràng, các yếu tố như độ tuổi, lựa chọn điều trị, thể trạng người bệnh cũng như mức độ đáp ứng điều trị cũng ảnh hưởng đến kết quả điều trị.',
      time: DateTime.now(),
      overview:
          'Ung thư màng phổi là gì? U trung biểu mô (mesothelioma) là ung thư xảy ra ở các lớp màng mỏng bao bọc các cơ quan trong cơ thể, bao gồm lớp biểu mô màng bụng, màng ngoài tim và màng phổi, vốn có nguồn gốc phôi thai từ trung bì phổi. Trong các vị trí trên, ung thư trung biểu mô xảy ra chủ yếu ở màng phổi. Ung thư trung biểu mô màng phổi (maglinant pleural mesothelioma) cũng là loại ung thư duy nhất của màng phổi được biết đến',
      details: diseaseArr,
      reason: "1. Một số loại thực phẩm có chứa nitrat. \n"
          "2. Thay đổi giấc ngủ hoặc thiếu ngủ. \n"
          "3. Tư thế xấu. \n"
          "4. Bỏ bữa. \n"
          "5. Căng thẳng. \n"),
  Disease(
      id: 2,
      doctor: 'Mr. Sam',
      title: 'Hurt heart',
      description: 'Description for disease',
      time: DateTime.now(),
      overview: 'Overview of disease',
      details: diseaseArr2,
      reason: "Reason 2")
];

