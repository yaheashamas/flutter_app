// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RealTypeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealType _$RealTypeFromJson(Map<String, dynamic> json) {
  return RealType(
    id: json['id'] as int,
    code: json['code'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$RealTypeToJson(RealType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
