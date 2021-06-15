// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OfferModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) {
  return Offer(
    id: json['id'] as int,
    description: json['description'] as String,
    userId: json['user_id'] as int,
    estateId: json['estate_id'] as int,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'estate_id': instance.estateId,
      'user_id': instance.userId,
      'user': instance.user?.toJson(),
    };
