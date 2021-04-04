import 'package:json_annotation/json_annotation.dart';
part 'CityModel.g.dart';

@JsonSerializable(explicitToJson: true)
class City {
  int id;
  String name;
  String code;
  City({this.id, this.code, this.name});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}
