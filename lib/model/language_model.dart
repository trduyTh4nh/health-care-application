class LanguageModel {
  String? flag;
  String? name;
  String? nativeName;
  String? code;
  LanguageModel({this.flag, this.name, this.nativeName, this.code});
}
List<LanguageModel> getLanguageList(){
  return [
    LanguageModel(flag: "🇻🇳", name: "Tiếng Việt", nativeName: "Tiếng Việt", code: "vn"),
    LanguageModel(flag: "🇺🇸", name: "Tiếng Anh (Mỹ)", nativeName: "American English", code: "us"),
    LanguageModel(flag: "🇵🇹", name: "Tiếng Bồ Đào Nha", nativeName: "Portugês", code: "pg"),
    LanguageModel(flag: "🇪🇸", name: "Tiếng Tây Ban Nha", nativeName: "Español", code: "es"),
    LanguageModel(flag: "🇨🇳", name: "Tiếng Trung (Giản thể)", nativeName: "中国人", code: "cn"),
    LanguageModel(flag: "🇹🇼", name: "Tiếng Trung (Phồn thể)", nativeName: "中國人", code: "tw"),
  ];
}