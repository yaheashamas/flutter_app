import 'package:json_annotation/json_annotation.dart';
import 'package:real_estate/models/CityModel.dart';
part 'AreaModel.g.dart';

@JsonSerializable(explicitToJson: true)
class Area {
  int id;
  String name;
  String code;
  @JsonKey(name: 'city_id')
  int cityId;
  City city;
  Area({this.id,this.code, this.name, this.cityId, this.city});

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
  Map<String, dynamic> toJson() => _$AreaToJson(this);
}
