import 'package:json_annotation/json_annotation.dart';
part 'RealTypeModel.g.dart';

@JsonSerializable(explicitToJson: true)
class RealType{
  String name;
  String code;
  RealType({this.code,this.name});

  factory RealType.fromJson(Map<String, dynamic> json) => _$RealTypeFromJson(json);
  Map<String, dynamic> toJson() => _$RealTypeToJson(this);
}