import 'package:real_estate/models/RealEstateModel.dart';
import '../utils/allUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RealEstateAPI {
  Future<List<RealEstate>> getAllRealEstate(typeRealEstate) async {
    List<RealEstate> allrealEstates = [];
    var url = device + realEstates;
    Map data = {"id": typeRealEstate};
    var body = convert.json.encode(data);
    var response = await http
        .post(url, body: body, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var responseBody =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var realEstate = responseBody['data'];
      for (var item in realEstate) {
        allrealEstates.add(RealEstate.fromJson(item));
      }
      return allrealEstates;
    }
    return null;
  }
}
