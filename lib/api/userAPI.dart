import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import '../models/UserModel.dart';
import '../utils/allUrl.dart';

class UserApi {
  //send email and password then i Taking token
  Future<String> loginUser({Map card}) async {
    var url = Uri.http(device, getToken);
    var response = await http.post(url, body: card);
    var responseBody = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      String token = responseBody['token'].toString();
      return token;
    } else {
      print('incorrect email/password');
    }
    return null;
  }

  //geve token return information user
  Future<User> getInfoUserFromToken({String token}) async {
    // Read token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");

    var url = Uri.http(device, getInforUserFromToken);
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: 'Bearer $token',
      //  'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      var responseJsone =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var infoUser = responseJsone['user'];
      User user = User.fromJson(infoUser);
      return user;
    } else {
      print("token It's wrong");
    }
    return null;
  }

  //send infomation from form to backend
  Future<User> registerUser({Map card}) async {
    var url = Uri.http(device, userRegister);
    var response = await http.post(url,
        body: convert.jsonEncode(card),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
    if (response.statusCode == 201) {
      var responseJsone =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var infoUser = responseJsone['data'];
      User user = User.fromJson(infoUser);
      return user;
    } else {
      User userError = new User();
      userError = null;
      return userError;
    }
  }
}
