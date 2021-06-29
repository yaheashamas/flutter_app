import 'package:flutter/material.dart';
class NotifivationScreen extends StatefulWidget {
  NotifivationScreen({Key key}) : super(key: key);
  @override
  _NotifivationScreenState createState() => _NotifivationScreenState();
}

class _NotifivationScreenState extends State<NotifivationScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //build future builder
        body: Center(child: Text("notification"))
    );
  }
}
