import 'dart:io';

import 'package:real_estate/models/RealTypeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/allUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TypeAPI {

  getAllType() async {

    // Read token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");
  
    List<RealType> allType = [];
    var url = Uri.http(device,type);
    var response = await http.get(url,headers: {
      HttpHeaders.authorizationHeader : 'Bearer $token',
    }
    );
    if (response.statusCode == 200) {
      var responseBody = convert.jsonDecode(response.body);
      var data = responseBody['data'];
      for (var item in data) {
        allType.add(RealType.fromJson(item));
      }
      return allType;
    }
  }
}
