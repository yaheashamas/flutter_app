import 'package:json_annotation/json_annotation.dart';
part 'RegisterModel.g.dart';

@JsonSerializable(explicitToJson: true)
class Register {
  int id;
  String name;
  String code;
  Register({this.id,this.code, this.name});

  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}
