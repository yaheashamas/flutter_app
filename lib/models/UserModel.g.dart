// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    phone: json['phone_number'] as int,
    xlatitude: (json['x_latitude'] as num)?.toDouble(),
    ylongitude: (json['y_latitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone_number': instance.phone,
      'x_latitude': instance.xlatitude,
      'y_latitude': instance.ylongitude,
    };
