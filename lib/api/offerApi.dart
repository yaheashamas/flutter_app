import 'dart:io';
import 'package:real_estate/models/OfferModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/allUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class OfferApi {
  saveOffer({Map card}) async {
    // Read token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");

    var body = convert.jsonEncode(card);
    var url = Uri.http(device, addNewOffer);
    var response = await http.post(url, body: body, headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  allOffer({int idEstate}) async {
    // Read token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");
    List<Offer> allOffer = [];

    var url = Uri.http(device, allOfferByEstate + idEstate.toString());
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var responseBody =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var data = responseBody["data"];
      for (var item in data) {
        allOffer.add(Offer.fromJson(item));
      }
      return allOffer;
    } else {
      return allOffer;
    }
  }
}
