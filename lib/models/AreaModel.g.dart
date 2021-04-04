// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AreaModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Area _$AreaFromJson(Map<String, dynamic> json) {
  return Area(
    code: json['code'] as String,
    name: json['name'] as String,
    cityId: json['city_id'] as int,
    city: json['city'] == null
        ? null
        : City.fromJson(json['city'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AreaToJson(Area instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'city_id': instance.cityId,
      'city': instance.city?.toJson(),
    };
