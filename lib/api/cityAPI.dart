import 'package:real_estate/models/CityModel.dart';
import '../utils/allUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CityAPI {
  Future<List<City>> getAllCities() async {
    List<City> listCities = List<City>();
    var url = device + cities;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var responseBody =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var data = responseBody['data'];
      for (var item in data) {
        listCities.add(City.fromJson(item));
      }
      return listCities;
    }
  }
}
