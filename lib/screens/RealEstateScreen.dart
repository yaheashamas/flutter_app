import 'package:flutter/material.dart';
import 'package:real_estate/screens/Screen%20TabBar/TapHomeScreen.dart';

class RealEstateScreen extends StatefulWidget {
  RealEstateScreen({Key key}) : super(key: key);
  @override
  _RealEstateScreenState createState() => _RealEstateScreenState();
}

class _RealEstateScreenState extends State<RealEstateScreen>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: Colors.blue[200],
            bottom: TabBar(tabs: [
              Tab(
                  child: Text(
                "بيت",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
              Tab(
                  child: Text(
                "محل",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
              Tab(
                  child: Text(
                "أرض",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
            ], controller: _tabController),
          ),
        ),
        body: Center(
            child: TabBarView(
          children: [
            TapHomeScreen(
              typeRealEstate: 1,
            ),
            TapHomeScreen(
              typeRealEstate: 2,
            ),
            TapHomeScreen(
              typeRealEstate: 3,
            ),
          ],
          controller: _tabController,
        )));
  }
}
