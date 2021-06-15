import 'package:flutter/material.dart';
// get info form and send to page Auth to method login
import 'package:provider/provider.dart';
import 'package:real_estate/api/userAPI.dart';
import 'package:real_estate/screens/HomePage.dart';
import 'package:real_estate/screens/RegisterScreen.dart';
import 'package:real_estate/services/auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //woring is send email or password not correct
  final snackBar = SnackBar(
    content: Text('يوجد خطأ في كلمة السر او الايميل'),
    duration: Duration(seconds: 5),
    backgroundColor: Colors.red,
  );

  bool _passwordVisible;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //this key for all this page
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //Activate this function when submitting data from the form
  singin({Map card}) async {
    var formdata = _formKey.currentState;
    if (formdata.validate()) {
      UserApi userApi = new UserApi();
      String token = await userApi.loginUser(card: card);
      if (token != null) {
        //send email and password the first one
        Provider.of<Auth>(context, listen: false).tryToken(token: token);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } else if (token == null) {
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }

  //When you leave the page, you clear the information
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  //Email
  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
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
          labelText: 'البريد الالكتروني',
          prefixIcon: Icon(Icons.email)),
      controller: _emailController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'بريد الالكتروني مطلوب';
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
        labelText: 'كلمة السر',
        prefixIcon: Icon(Icons.lock),
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
      // show error fist see page
      // autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordController,
      obscureText: !_passwordVisible,
      validator: (String value) {
        if (value.isEmpty) {
          return 'كلمة السر مطلوبة';
        }
        if (value.length < 5) {
          return 'يجب ان تكون اكبر من 5 محارف';
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
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              children: [
                Container(
                    height: 200,
                    child: Image(
                      image: AssetImage("images/login.png"),
                      fit: BoxFit.cover,
                    )),
                SizedBox(height: 25),
                _buildEmail(),
                SizedBox(height: 25),
                _buildPassword(),
                SizedBox(height: 25),
                FlatButton(
                  padding: EdgeInsets.all(10.0),
                  minWidth: double.infinity,
                  color: Colors.blue,
                  child: Container(
                      child: Text("تسجيل دخول",
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () {
                    // get information form email and password
                    Map cards = {
                      'email': _emailController.text,
                      'password': _passwordController.text
                    };
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
                    singin(card: cards);
                  },
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        minWidth: 50,
                        child: Container(
                            child: Text("اضغط هنا",
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline))),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterScreen()));
                        }),
                    Text("ليس لديك حساب ؟"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
