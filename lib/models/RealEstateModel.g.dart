// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RealEstateModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealEstate _$RealEstateFromJson(Map<String, dynamic> json) {
  return RealEstate(
    id: json['id'] as int,
    rentOrSale: (json['rent_or_sale'] as num)?.toDouble(),
    numberMonth: json['number_month'] as int,
    price: json['price'] as int,
    space: json['space'] as int,
    locationDescription: json['location_description'] as String,
    xLatitude: (json['x_latitude'] as num)?.toDouble(),
    yLongitude: (json['y_longitude'] as num)?.toDouble(),
    specifications: json['specifications'] as Map<String, dynamic>,
    userId: json['user_id'] as int,
    areaId: json['area_id'] as int,
    realEstateRegistryId: json['realEstateRegistry_id'] as int,
    realEstateTypeId: json['realEstateType_id'] as int,
    images: (json['images'] as List)
        ?.map(
            (e) => e == null ? null : Image.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    area: json['area'] == null
        ? null
        : Area.fromJson(json['area'] as Map<String, dynamic>),
    register: json['register'] == null
        ? null
        : Register.fromJson(json['register'] as Map<String, dynamic>),
    realType: json['type'] == null
        ? null
        : RealType.fromJson(json['type'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RealEstateToJson(RealEstate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rent_or_sale': instance.rentOrSale,
      'number_month': instance.numberMonth,
      'location_description': instance.locationDescription,
      'x_latitude': instance.xLatitude,
      'y_longitude': instance.yLongitude,
      'user_id': instance.userId,
      'area_id': instance.areaId,
      'realEstateRegistry_id': instance.realEstateRegistryId,
      'realEstateType_id': instance.realEstateTypeId,
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
      'specifications': instance.specifications,
      'price': instance.price,
      'space': instance.space,
      'area': instance.area?.toJson(),
      'type': instance.realType?.toJson(),
      'register': instance.register?.toJson(),
    };
