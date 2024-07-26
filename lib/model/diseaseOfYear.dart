
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class Diseaseofyear {
  String? month;
  String? count;


  Diseaseofyear(
      {this.month,
      this.count,
});

  factory Diseaseofyear.fromJson(Map<String, dynamic> json) => _$DiseaseofyearFromJson(json);
  Map<String, dynamic> toJson() => _$DiseaseofyearToJson(this);

}

Diseaseofyear _$DiseaseofyearFromJson(Map<String, dynamic> json) => Diseaseofyear(
  month: (json['month'] as String?),
  count: (json['count'] as String?),
);

Map<String, dynamic> _$DiseaseofyearToJson(Diseaseofyear instance) => 
  <String, dynamic> {
    'month': instance.month,
    'count': instance.count,
  };
