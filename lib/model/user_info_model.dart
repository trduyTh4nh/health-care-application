class InfoUserModel {
  int? idUser;
  String? userName;
  String? email;
  ProfileUserModel? profile;

  InfoUserModel({this.idUser, this.userName, this.email, this.profile});

  factory InfoUserModel.fromJson(Map<String, dynamic> json) {
    return InfoUserModel(
      idUser: json['id_user'] is int
          ? json['id_user']
          : int.tryParse(json['id_user'].toString()),
      userName: json['username'],
      email: json['email'],
      profile: json['profile'] != null
          ? ProfileUserModel.fromJson(json['profile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'username': userName,
      'email': email,
      'profile': profile?.toJson(),
    };
  }
}

class ProfileUserModel {
  int? idResume;
  int? height;
  int? weight;
  int? age;
  String? gender;
  String? address;
  int? idUser;
  String? avatar;
  String? phone;
  String? fullName;

  ProfileUserModel({
    this.idResume,
    this.height,
    this.weight,
    this.age,
    this.gender,
    this.address,
    this.idUser,
    this.avatar,
    this.phone,
    this.fullName,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      idResume: json['id_resume'] is int
          ? json['id_resume']
          : int.tryParse(json['id_resume'].toString()),
      height: json['height'] is int
          ? json['height']
          : int.tryParse(json['height'].toString()),
      weight: json['weight'] is double
          ? json['weight']
          : int.tryParse(json['weight'].toString()),
      age: json['age'] is int
          ? json['age']
          : int.tryParse(json['age'].toString()),
      gender: json['gender']?.toString(),
      address: json['address']?.toString(),
      idUser: json['id_user'] is int
          ? json['id_user']
          : int.tryParse(json['id_user'].toString()),
      avatar: json['avatar']?.toString(),
      phone: json['phone']?.toString(),
      fullName: json['full_name']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_resume': idResume,
      'height': height,
      'weight': weight,
      'age': age,
      'gender': gender,
      'address': address,
      'id_user': idUser,
      'avatar': avatar,
      'phone': phone,
      'full_name': fullName,
    };
  }
}
