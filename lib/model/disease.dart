import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class Disease {
  int? id_disease;
  String? disease_name;


  Disease(
      {this.id_disease,
      this.disease_name,});

  factory Disease.fromJson(Map<String, dynamic> json) => _$DiseaseFromJson(json);
  Map<String, dynamic> toJson() => _$DiseaseToJson(this);


 
}

Disease _$DiseaseFromJson(Map<String, dynamic> json) => Disease(
  id_disease: (json['id_disease'] as num?)?.toInt(),
  disease_name: (json['disease_name'] as String?),
);

Map<String, dynamic> _$DiseaseToJson(Disease instance) => 
  <String, dynamic> {
    'id_disease': instance.id_disease,
    'disease_name': instance.disease_name,
  };
