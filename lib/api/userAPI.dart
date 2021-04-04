import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/UserModel.dart';
import '../utils/allUrl.dart';

class UserApi {
  //send email and password then i Taking token
  Future<String> loginUser({Map card}) async {
    var url = device + getToken;
    var response = await http.post(url, body: card);
    var responseBody = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      String token = responseBody['token'].toString();
      return token;
    } else {
      print('incorrect email/password');
    }
  }

  //geve token return information user
  Future<User> getInfoUserFromToken({String token}) async {
    var url = device + getInforUserFromToken;
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var responseJsone =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var infoUser = responseJsone['user'];
      User user = User.fromJson(infoUser);
      return user;
    } else {
      print("token It's wrong");
    }
  }

  //send infomation from form to backend
  Future<User> registerUser({Map card}) async {
    var url = device + userRegister;
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

//   Future<List<User>> getAllUser() async {
//     List<User> users = List<User>();
//     var url = device + allUsers;
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       var responseBody =
//           convert.jsonDecode(response.body) as Map<String, dynamic>;
//       var alluser = responseBody['data'];
//       for (var item in alluser) {
//         users.add(User.fromJson(item));
//       }
//     }
//     return users;
//   }
// }
}
