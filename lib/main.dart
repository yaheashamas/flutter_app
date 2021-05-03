import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:real_estate/screens/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/screens/LoginScreen.dart';
import 'package:real_estate/screens/MyAccount.dart';
import 'package:real_estate/screens/NotificationScreen.dart';
import 'package:real_estate/screens/Screen%20TabBar/TapHomeScreen.dart';
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
        theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
        routes: {
          'myAccount': (context) {
            return MyAcount();
          },
          'notification': (context) {
            return NotifivationScreen();
          },
          'home': (context) {
            return TapHomeScreen();
          }
        },
        builder: EasyLoading.init(),
      ),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
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
