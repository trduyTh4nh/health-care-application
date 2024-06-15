class Hospital {
  int idHospital;
  String name;
  String address;
  String phone;
  DateTime createDate;
  String contactInfomation;
  String imageHospital;

  Hospital({
    required this.idHospital,
    required this.name,
    required this.address,
    required this.phone,
    required this.createDate,
    required this.contactInfomation,
    required this.imageHospital,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        idHospital: json[''],
        name: json[''],
        address: json[''],
        phone: json[''],
        createDate: json[''],
        contactInfomation: json[''],
        imageHospital: json[''],
      );
}
