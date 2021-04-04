import 'package:json_annotation/json_annotation.dart';
part 'ImageModel.g.dart';

@JsonSerializable(explicitToJson: true)
class Image{
  String url;
  @JsonKey(name: 'estate_id')
  int estateId;
  Image({this.url,this.estateId});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
  Map<String, dynamic> toJson() => _$ImageToJson(this);

}
