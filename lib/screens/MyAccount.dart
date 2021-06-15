import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/drawer/NavigatorDrawer.dart';
import 'package:real_estate/models/UserModel.dart';
import 'package:real_estate/screens/AddNewReal.dart';
import 'package:real_estate/screens/LoginScreen.dart';
import 'package:real_estate/screens/myRealEstate.dart';
import 'package:real_estate/services/auth.dart';

class MyAcount extends StatefulWidget {
  MyAcount({Key key}) : super(key: key);

  @override
  _MyAcountState createState() => _MyAcountState();
}

class _MyAcountState extends State<MyAcount> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  User user;

  User getInfoUser(context) {
    User user = Provider.of<Auth>(context, listen: false).user;
    return user;
  }

  @override
  void initState() {
    super.initState();
    user = getInfoUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      drawer: NavigatorDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 200,
                    height: 200,
                    decoration: new BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/male.png"),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle,
                    ),
                  ),
                  user == null
                      ? Container()
                      : Column(
                          children: [
                            Text(user.name),
                            Text(user.phone.toString()),
                            Text(user.email)
                          ],
                        )
                ],
              ),
            ),
            SizedBox(height: 60),
            InkWell(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.grey[600],
                      size: 25,
                    ),
                    Text(
                      "اضافة عقار",
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddNewReal()));
              },
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(color: Colors.grey),
                height: 0.5,
                width: 100,
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.corporate_fare_rounded,
                      color: Colors.grey[600],
                      size: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: Text(
                        "عقاراتي",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyRealEstate(idUser: user.id)));
              },
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(color: Colors.grey),
                height: 0.5,
                width: 200,
              ),
            ),
            SizedBox(height: 20),
            Consumer<Auth>(
              builder: (context, provider, child) {
                return InkWell(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.grey[600],
                          size: 25,
                        ),
                        Text(
                          "تسجيل خروج",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    /*click logout code move to page {auth} to function logout
                      * chane authintication ture => false
                      */
                    provider.logout();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen()));
                  },
                );
              },
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(color: Colors.grey),
                height: 0.5,
                width: 100,
              ),
            ),
            SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}
