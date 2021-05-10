import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate/api/realEstateAPI.dart';
import 'package:real_estate/models/RealEstateModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:real_estate/screens/DescRealEstateScreen.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  String sreachAddr;
  List<Marker> markers = [];
  List<RealEstate> allReal;
  LatLng currntLocation = _initialCameraPostion.target;

  static final CameraPosition _initialCameraPostion = CameraPosition(
    target: LatLng(35.510414, 38.278336),
    zoom: 6,
  );

  allRealEstates() async {
    RealEstateAPI realEstateAPI = new RealEstateAPI();
    List<RealEstate> realEstates = await realEstateAPI.allRealEstates();
    setState(() {
      allReal = realEstates;
    });
    for (RealEstate item in allReal) {
      FlutterMoneyFormatter fmf =
          FlutterMoneyFormatter(amount: item.price + .0);
      markers.add(Marker(
          markerId: MarkerId(item.id.toString()),
          position: LatLng(item.xLatitude, item.yLongitude),
          infoWindow: InfoWindow(
              title: item.rentOrSale == 0.0
                  ? "${item.realType.name} , للبيع"
                  : "${item.realType.name} ,  للاجار",
              snippet: fmf.output.withoutFractionDigits,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DescRealEstateScreen(estate: item)));
              })));
    }
  }

  @override
  void initState() {
    super.initState();
    allRealEstates();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) {
            setState(() {
              mapController = controller;
            });
          },
          initialCameraPosition: _initialCameraPostion,
          markers: markers.toSet(),
          onCameraMove: (CameraPosition newpos) {
            setState(() {
              currntLocation = newpos.target;
            });
          },
          mapType: MapType.hybrid,
        ),
        Positioned(
            bottom: 100,
            right: -16,
            child: RawMaterialButton(
              onPressed: () async {
                allReal.map((e) => print(e.area));
                Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(position.latitude, position.longitude),
                        zoom: 17.0)));
              },
              elevation: 1.0,
              fillColor: Colors.blue[300],
              child: Icon(
                Icons.my_location,
                size: 25.0,
              ),
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
            )),
      ],
    );
  }
}
