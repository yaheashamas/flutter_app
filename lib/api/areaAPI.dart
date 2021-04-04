import 'package:real_estate/models/AreaModel.dart';
import '../utils/allUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AreaAPi {
  getAllArea({int idCity}) async {
    List<Area> allAreaFromSpecificCity = List<Area>();
    Map data = {"id": idCity};
    var body = convert.jsonEncode(data);
    var url = device + areas;
    var response = await http
        .post(url, body: body, headers: {"Content-Type": "application/json"});
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
