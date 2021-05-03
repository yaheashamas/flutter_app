import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class AddressMap extends StatefulWidget {
  AddressMap({Key key}) : super(key: key);

  @override
  _AddressMapState createState() => _AddressMapState();
}

class _AddressMapState extends State<AddressMap> {
  GoogleMapController mapController;
  String sreachAddr;
  Marker marker = Marker(markerId: MarkerId("0"));
  int id = Random().nextInt(100);
  LatLng fposition;

  addmarker(cordinate) {
    setState(() {
      marker = Marker(markerId: MarkerId(id.toString()), position: cordinate);
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
          markers: marker != null ? <Marker>[marker].toSet() : null,
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
                  LatLng latLng = LatLng(position.latitude, position.longitude);
                  addmarker(latLng);
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
        Positioned(
          bottom: 20,
          left: 20,
          child: Container(
            width: 150,
            height: 40,
            child: ElevatedButton(
              child: Text("حفظ"),
              onPressed: () {
                fposition = marker.position;
                if (fposition != null) {
                  Navigator.pop(context,fposition);
                } else {
                  print("postion is null");
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[300],
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
