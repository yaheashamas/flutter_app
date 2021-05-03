import 'package:real_estate/models/RealEstateModel.dart';
import '../utils/allUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RealEstateAPI {
  Future<List<RealEstate>> getAllRealEstate(typeRealEstate) async {
    List<RealEstate> allrealEstates = [];
    var url = Uri.http(device, realEstates);
    Map data = {"id": typeRealEstate};

    var body = convert.json.encode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
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

  Future<RealEstate> addNewRealEstate({Map card, int idUser}) async {
    var url = Uri.http(device, addRealEstate + idUser.toString());
    var response = await http.post(
      url,
      body: convert.jsonEncode(card),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );
    if (response.statusCode == 201) {
      var responseBody =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var data = responseBody['data'];
      RealEstate real = RealEstate.fromJson(data);
      return real;
    } else {
      return null;
    }
  }
}
