import 'dart:io';

import 'package:real_estate/models/CityModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/allUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CityAPI {
  Future<List<City>> getAllCities() async {
    // Read token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");

    List<City> listCities = [];
    var url = Uri.http(device, cities);
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var responseBody =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var data = responseBody['data'];
      for (var item in data) {
        listCities.add(City.fromJson(item));
      }
      return listCities;
    }
    return null;
  }
}
