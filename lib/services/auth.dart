import 'package:flutter/material.dart';
import '../api/userAPI.dart';
//model User
import '../models/UserModel.dart';
//storage token = cockis
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  bool _isLogIn = false;
  User _user;
  String _token;

  //call _isLogIn and user OutSide class
  bool get authenticated => _isLogIn;
  User get user => _user;
  String get token => _token;

  //Make a copy class User APi
  UserApi userApi = new UserApi();

  // Remove token in moble and backend
  logout() {
    cleanToken();
    notifyListeners();
  }

  //login Second way send token get info user
  tryToken({String token}) async {
    if (token == null) {
      return;
    } else {
      // Save Info User
      this._user = await userApi.getInfoUserFromToken(token: token);
      this._isLogIn = true;
      
      //function to save token in mobaile
      this.storeToken(token: token);
      notifyListeners();
    }
  }

  //save token
  storeToken({String token}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
    this._token = preferences.getString("token");
  }

  //clear all token
  cleanToken() async {
    this._user = null;
    this._isLogIn = false;
    this._token = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("token");
    preferences.remove("email");
    preferences.remove("password");
  }
}
