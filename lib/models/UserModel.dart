import 'package:json_annotation/json_annotation.dart';
part 'UserModel.g.dart';

@JsonSerializable()
class User {
  String name;
  String email;
  String password;
  @JsonKey(name: 'phone_number')
  int phone;
  @JsonKey(name: 'x_latitude')
  double xlatitude;
  @JsonKey(name: 'y_latitude')
  double ylongitude;

  User(
      {
        this.name,
        this.email,
        this.password,
        this.phone,
        this.xlatitude,
        this.ylongitude
      }
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
