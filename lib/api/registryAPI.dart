import 'dart:io';

import 'package:real_estate/models/RegisterModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/allUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RegistryAPI {
  
  getAllRegistry() async {
    // Read token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");

    List<Register> allRefister = [];
    var url = Uri.http(device,registry);
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader : 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var responseBody = convert.jsonDecode(response.body);
      var data = responseBody['data'];
      for (var item in data) {
        allRefister.add(Register.fromJson(item));
      }
      return allRefister;
    }
  }
}
