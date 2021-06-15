import 'dart:io';

import 'package:real_estate/models/AreaModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/allUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AreaAPi {
  getAllArea({int idCity}) async {

    // Read token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");
    
    List<Area> allAreaFromSpecificCity = [];

    Map data = {"id": idCity};
    var body = convert.jsonEncode(data);
    var url = Uri.http(device, areas);

    var response = await http
        .post(url, body: body, headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader : 'Bearer $token',
        });

    if (response.statusCode == 200) {
      var responseBody =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var data = responseBody['data'];
      for (var item in data) {
        allAreaFromSpecificCity.add(Area.fromJson(item));
      }
      return allAreaFromSpecificCity;
    }
  }
}
