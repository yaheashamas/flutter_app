import 'package:json_annotation/json_annotation.dart';
import 'package:real_estate/models/RealEstateModel.dart';
import 'package:real_estate/models/UserModel.dart';
part 'OfferModel.g.dart';

@JsonSerializable(explicitToJson: true)
class Offer {
  int id;
  String description;
  @JsonKey(name: 'estate_id')
  int estateId;
  @JsonKey(name: 'user_id')
  int userId;
  @JsonKey(name: 'user')
  User user;
  Offer({
    this.id,
    this.description,
    this.userId,
    this.estateId,
    this.user
  });
  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  Map<String, dynamic> toJson() => _$OfferToJson(this);
}
