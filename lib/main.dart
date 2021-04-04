import 'package:flutter/material.dart';
import 'package:real_estate/screens/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/screens/LoginScreen.dart';
import 'package:real_estate/screens/MyAccount.dart';
import 'package:real_estate/screens/NotificationScreen.dart';
import 'package:real_estate/services/auth.dart';
//storage token = cockis
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity
        ),
        routes:{
          'myAccount' :(context){return MyAcount();},
          'notification' : (context){return NotifivationScreen();},
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");
    return token;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getToken(),
        builder: (BuildContext context, AsyncSnapshot<String> value) {
          if (value.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (value.data != null)
            return HomePage();
          else
            return LoginScreen();
        },
      ),
    );
  }
}
