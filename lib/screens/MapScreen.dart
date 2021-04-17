import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
const kGoogleApiKey = "AIzaSyAgSKNWY7AP8fLm4Vpb3uhEjCUIK7MtKGw";

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  String sreachAddr;
  List<Marker> markers = [];

  addmarker(cordinate) {
    int id = Random().nextInt(100);
    setState(() {
      markers = [];
      markers
          .add(Marker(markerId: MarkerId(id.toString()), position: cordinate));
    });
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
          markers: markers.toSet(),
          onTap: (cordinate) async {
            mapController.animateCamera(CameraUpdate.newLatLng(cordinate));
            addmarker(cordinate);
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(35.510414, 38.278336),
            zoom: 6,
          ),
          mapType: MapType.hybrid,
        ),
        Positioned(
            top: 30,
            right: 0,
            child: RawMaterialButton(
              onPressed: () {
              },
              elevation: 1.0,
              fillColor: Colors.blue[300],
              child: Icon(
                Icons.search,
                size: 25.0,
              ),
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
            )),
      ],
    );
  }
}
