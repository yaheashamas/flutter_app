import 'package:json_annotation/json_annotation.dart';
import 'package:real_estate/models/AreaModel.dart';
import 'package:real_estate/models/ImageModel.dart';
import 'package:real_estate/models/RegisterModel.dart';
import 'package:real_estate/models/RealTypeModel.dart';
part 'RealEstateModel.g.dart';

@JsonSerializable(explicitToJson: true)
class RealEstate{
  @JsonKey(name: 'rent_or_sale')
  double rentOrSale;
  @JsonKey(name: 'number_month')
  int numberMonth;
  @JsonKey(name: 'location_description')
  String locationDescription;
  @JsonKey(name: 'x_latitude')
  double 	xLatitude;
  @JsonKey(name: 'y_longitude')
  double 	yLongitude;
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'area_id')
  int areaId;
  @JsonKey(name: 'realEstateRegistry_id')
  int realEstateRegistryId;
  @JsonKey(name: 'realEstateType_id')
  int realEstateTypeId;
  @JsonKey(name: 'images')
  List<Image> images;
  Map<String,dynamic> specifications;
  int price;
  int space;
  @JsonKey(name: 'area')
  Area area;
  @JsonKey(name: 'type')
  RealType realType; 
  @JsonKey(name: 'register')
  Register register;

  RealEstate({
    this.rentOrSale,
    this.numberMonth,
    this.price,
    this.space,
    this.locationDescription,
    this.xLatitude,
    this.yLongitude,
    this.specifications,
    this.userId,
    this.areaId,
    this.realEstateRegistryId,
    this.realEstateTypeId,
    this.images,
    this.area,
    this.register,
    this.realType
  });

  factory RealEstate.fromJson(Map<String, dynamic> json) => _$RealEstateFromJson(json);

  Map<String, dynamic> toJson() => _$RealEstateToJson(this);

}
