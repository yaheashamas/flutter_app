import 'package:flutter/material.dart';
import 'package:real_estate/api/realEstateAPI.dart';
import 'package:real_estate/screens/card/RealEstateCard.dart';
import '../../models/RealEstateModel.dart';

// ignore: must_be_immutable
class TapHomeScreen extends StatefulWidget {
  int typeRealEstate;
  TapHomeScreen({this.typeRealEstate});

  @override
  _TapHomeScreenState createState() => _TapHomeScreenState();
}

class _TapHomeScreenState extends State<TapHomeScreen> {
  int typeRealEstate;

  //cache save all cities
  
  Future<List<RealEstate>> getAllRealEstates() async {
    RealEstateAPI realEstateAPI = new RealEstateAPI();
    Future<List<RealEstate>> allrealEstates =
        realEstateAPI.getAllRealEstate(typeRealEstate);
    return allrealEstates;
  }

  @override
  void initState() {
    super.initState();
    getAllRealEstates();
    typeRealEstate = widget.typeRealEstate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<RealEstate>>(
            future: getAllRealEstates(),
            builder: (context, snapshot) {
              //the data not raede return circular
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              }
              List<RealEstate> estates = snapshot.data ?? [];
              return Container(
                  child: estates.isEmpty
                      ? Center(
                          child: Text(
                          "لا يوجد عقارات حاليا",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ))
                      : ListView.builder(
                          itemCount: estates.length,
                          itemBuilder: (context, index) {
                            RealEstate estate = estates[index];
                            return RealEstateCard(realEstate: estate);
                          }));
            }));
  }
}
