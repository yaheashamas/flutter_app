import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  String sreachAddr;
  List<Marker> markers = [];
  int id = Random().nextInt(100);

  addmarker(cordinate) {
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
            bottom: 100,
            right: -16,
            child: RawMaterialButton(
              onPressed: () async {
                Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(position.latitude, position.longitude),
                        zoom: 17.0)));
                setState(() {
                  markers.add(Marker(
                      markerId: MarkerId(id.toString()),
                      position: LatLng(position.latitude, position.longitude)));
                });
                
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
