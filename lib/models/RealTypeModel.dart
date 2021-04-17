import 'package:json_annotation/json_annotation.dart';
part 'RealTypeModel.g.dart';

@JsonSerializable(explicitToJson: true)
class RealType {
  int id;
  String name;
  String code;
  RealType({this.id,this.code, this.name});

  factory RealType.fromJson(Map<String, dynamic> json) =>
      _$RealTypeFromJson(json);
  Map<String, dynamic> toJson() => _$RealTypeToJson(this);
}
