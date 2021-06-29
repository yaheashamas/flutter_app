import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate/api/userAPI.dart';
import 'package:real_estate/models/UserModel.dart';
import 'package:real_estate/screens/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen();

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String tokenNoti ;
  //seccess is send email or password not correct
  final snackBarSeccess = SnackBar(
    content: Text('تم التسجيل بنجاح'),
    duration: Duration(seconds: 5),
    backgroundColor: Colors.green,
  );

  //woring is send email or password not correct
  final snackBarWoring = SnackBar(
    content: Text('البريد الالكتروني او رقم الموبايل موجودة بلفعل'),
    duration: Duration(seconds: 5),
    backgroundColor: Colors.red,
  );

  //get token notification
  getTokenNotification() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String tokennotification = sharedPreferences.getString('tokenNoti');
    setState(() {
      tokenNoti = tokennotification;
    });
  }

  @override
  void initState() {
    getTokenNotification();
    _passwordVisible = false;
    super.initState();
  }

  bool _passwordVisible;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //this key for all this page
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //When you leave the page, you clear the information
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  register({Map card}) async {
    var formdata = _formKey.currentState;
    if (formdata.validate()) {
      UserApi userApi = new UserApi();
      User user = await userApi.registerUser(card: card);
      if (user != null) {
        _scaffoldKey.currentState.showSnackBar(snackBarSeccess);
        Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
        });

      } else {
        _scaffoldKey.currentState.showSnackBar(snackBarWoring);
      }
    } else {}
  }

  //build inputs

  //Name
  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: 'الاسم',
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      maxLength: 20,
      controller: _nameController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'الاسم مطلوب';
        }
        return null;
      },
    );
  }

  //Email
  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        labelText: 'البريد الالكتروني',
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      controller: _emailController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'البريد الالكتروني مطلوب';
        }
        if (!RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(value)) {
          return "ادخل الايميل بنسق صحيح examp@gmail.com";
        }
        return null;
      },
    );
  }

  //Password
  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: 'كلمة السر',
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordController,
      obscureText: !_passwordVisible,
      validator: (String value) {
        if (value.isEmpty) {
          return 'كلمة السر مطلوبة';
        }
        if (value.length < 7) {
          return 'يجب ان تكون اكبر من 5 محارف';
        }
        return null;
      },
    );
  }

  //Phone_number
  Widget _buildPhoneNumber() {
    String pattern = r'(^[0]{1}[9]{1}[0-9]{8}$)';
    RegExp regExp = new RegExp(pattern);
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone),
        labelText: 'رقم الموبايل',
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _phoneNumberController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (String value) {
        if (value.isEmpty) {
          return 'رقم الموبايل مطلوب';
        }
        if (!regExp.hasMatch(value)) {
          if (value.length > 10) {
            return "الارقام اكثر من 10";
          } else if (value.length < 10) {
            return "الارقام اقل من 10";
          } else {
            return 'يجب ان يبدء رقم الموبايل 09';
          }
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: Column(
              children: [
                Container(
                    height: 200,
                    child: Image(
                        image: AssetImage("images/register.png"),
                        fit: BoxFit.cover)),
                SizedBox(height: 15),
                _buildName(),
                _buildEmail(),
                SizedBox(height: 15),
                _buildPassword(),
                SizedBox(height: 15),
                _buildPhoneNumber(),
                SizedBox(height: 30),
                FlatButton(
                  padding: EdgeInsets.all(10),
                  minWidth: double.infinity,
                  color: Colors.blue,
                  child: Container(
                      child:
                          Text("ارسال", style: TextStyle(color: Colors.white))),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () {
                    // get information form email and password
                    Map cards = {
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'password': _passwordController.text,
                      'phone_number': int.tryParse(_phoneNumberController.text),
                      'fcm_token':tokenNoti
                    };
                    print(cards);
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      duration: new Duration(seconds: 0),
                      content: Row(
                        children: <Widget>[
                          new CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.blue)),
                          new Text("  انتظر بضع ثواني")
                        ],
                      ),
                    ));
                    register(card: cards);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
