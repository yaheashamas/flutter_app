import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/screens/MapScreen.dart';
import 'package:real_estate/screens/SerachScreen.dart';
import 'package:real_estate/screens/realEstateScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth.dart';
import '../screens/MyAccount.dart';
import '../screens/NotificationScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _activePage = 2;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Widget> _tabItems = [
    MyAcount(),
    SearchScreen(),
    RealEstateScreen(),
    NotifivationScreen(),
    MapScreen(),
  ];

  readToken() async {
    // Read token
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");
    // You saved the token, and every time you send it to ClassAuth
    await Provider.of<Auth>(context, listen: false).tryToken(token: token);
  }

  @override
  void initState() {
    super.initState();
    readToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // navigation bar
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.perm_identity, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.notifications, size: 30),
          Icon(Icons.map, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.blue[200],
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOutExpo,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _activePage = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      //body Home
      body: _tabItems[_activePage],
    );
  }
}
