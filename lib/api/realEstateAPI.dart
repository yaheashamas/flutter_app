import 'dart:io';

import 'package:real_estate/models/RealEstateModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/allUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RealEstateAPI {
  Future<List<RealEstate>> getAllRealEstate(typeRealEstate) async {
    // Read token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");

    List<RealEstate> allrealEstates = [];
    var url = Uri.http(device, realEstates);
    Map data = {"id": typeRealEstate};
    var body = convert.json.encode(data);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        body: body);
    if (response.statusCode == 200) {
      var responseBody =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var realEstate = responseBody['data'];
      for (var item in realEstate) {
        allrealEstates.add(RealEstate.fromJson(item));
      }
      print({"allrealEstates =>>>>>>>>>>": allrealEstates});
      return allrealEstates;
    }
    return null;
  }

  Future<RealEstate> addNewRealEstate({Map card, int idUser}) async {
    // Read token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");

    var url = Uri.http(device, addRealEstate + idUser.toString());
    var response = await http.post(
      url,
      body: convert.jsonEncode(card),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
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

  allRealEstates() async {
    // Read token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");

    List<RealEstate> realEstates = [];
    var url = Uri.http(device, allRealEstate);
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var responseBody =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var data = responseBody['data'];
      for (var item in data) {
        realEstates.add(RealEstate.fromJson(item));
      }
      return realEstates;
    }
  }

  getAllRealEstateForUser({int id}) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");

    List<RealEstate> realEstates = [];

    var url = Uri.http(device, myRealEstate + id.toString());
    var response = await http.post(url, headers: {
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
      return realEstates;
    }
  }
}
