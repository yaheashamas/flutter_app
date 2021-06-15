import 'dart:convert';
import 'dart:io';

import 'package:real_estate/models/RealEstateModel.dart';
import 'package:real_estate/utils/allUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SearchApi {
  sreachAboutAllRealEstate({Map card}) async {
    // Read token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");

    List<RealEstate> realEstates = [];
    var body = convert.jsonEncode(card);
    var url = Uri.http(device, searchAboutRealEstate);

    var response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var responseBody = convert.jsonDecode(response.body);
      var data = responseBody['data'];
      for (var item in data) {
        realEstates.add(RealEstate.fromJson(item));
      }
      return realEstates;
    } else {
      print({"response.statusCode =>": response.statusCode});
    }
  }
}
