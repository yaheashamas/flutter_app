import 'package:real_estate/models/RegisterModel.dart';

import '../utils/allUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RegistryAPI {
  
  getAllRegistry() async {
    List<Register> allRefister = [];
    var url = device + registry;
    var response = await http.get(url);
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
