import 'package:json_annotation/json_annotation.dart';
part 'RegisterModel.g.dart';

@JsonSerializable(explicitToJson: true)
class Register{
  String name;
  String code;
  Register({this.code,this.name});

  factory Register.fromJson(Map<String, dynamic> json) => _$RegisterFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}