// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image(
    url: json['url'] as String,
    estateId: json['estate_id'] as int,
  );
}

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'url': instance.url,
      'estate_id': instance.estateId,
    };
