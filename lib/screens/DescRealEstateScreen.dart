import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/models/RealEstateModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:real_estate/models/UserModel.dart';
import 'package:real_estate/screens/newOffer.dart';
import 'package:real_estate/services/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DescRealEstateScreen extends StatefulWidget {
  final RealEstate estate;
  DescRealEstateScreen({this.estate});
  @override
  _DescRealEstateScreenState createState() => _DescRealEstateScreenState();
}

class _DescRealEstateScreenState extends State<DescRealEstateScreen> {
  RealEstate estate;
  List allUrlImages;
  int _current = 0;
  User user;

  User getInfoUser(context) {
    User user = Provider.of<Auth>(context, listen: false).user;
    return user;
  }

  GoogleMapController mapController;
  List<Marker> marker = [];
  int id = Random().nextInt(100);
  LatLng latLng;

  List allImages() {
    List listImages = [];
    for (var i = 0; i < estate.images.length; i++) {
      listImages.add(estate.images[i].url.toString());
    }
    return listImages;
  }

  @override
  void initState() {
    super.initState();
    estate = widget.estate;
    allUrlImages = allImages();
    latLng = LatLng(estate.xLatitude, estate.yLongitude);
    marker.add(Marker(markerId: MarkerId(id.toString()), position: latLng));
    user = getInfoUser(context);
  }

  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    double price = estate.price + .0;
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: price);
    Size size = MediaQuery.of(context).size;
    int phoneNumber = Provider.of<Auth>(context, listen: false).user.phone;
    User user = Provider.of<Auth>(context, listen: false).user;

    return ChangeNotifierProvider(
      create: (context) {
        return Auth();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Container(
                // layouts
                child: Stack(
                  children: [
                    // start images
                    CarouselSlider(
                      items: allUrlImages.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: NetworkImage(i),
                                fit: BoxFit.cover,
                              )),
                            );
                          },
                        );
                      }).toList(),
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          height: 450,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                    // strat posinter image
                    Positioned(
                      top: 340,
                      right: MediaQuery.of(context).size.width / 2.13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: allUrlImages.map((url) {
                          int index = allUrlImages.indexOf(url);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Colors.white),
                          );
                        }).toList(),
                      ),
                    ),
                    // end posinter image
                    // end images

                    // start slide discription
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, right: 15, left: 15, bottom: 20),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // price
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      " السعر",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    ),
                                    Text(fmf.output.withoutFractionDigits,
                                        style: TextStyle(
                                          fontSize: 23,
                                        )),
                                  ]),
                              SizedBox(height: 20),
                              // Specifications
                              Text(
                                "المواصفات",
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                              SizedBox(height: 20),
                              //start first row
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Icon(
                                        estate.realType.code == "HOME"
                                            ? Icons.roofing_outlined
                                            : Icons
                                                .store_mall_directory_outlined,
                                      ),
                                      Text(
                                        estate.realType.name,
                                      )
                                    ],
                                  )),
                                  Container(
                                    height: 35,
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Icon(Icons.room_outlined),
                                      Text(estate.area.name)
                                    ],
                                  )),
                                  Container(
                                    height: 35,
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Icon(Icons.location_city_rounded),
                                      Text(
                                        estate.area.city.name,
                                      )
                                    ],
                                  )),
                                ],
                              ),
                              //end first row
                              SizedBox(height: 15),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.grey),
                                  height: 0.3,
                                  width: 200,
                                ),
                              ),
                              SizedBox(height: 30),
                              //start last row
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Icon(Icons.architecture),
                                      Text(estate.space.toString())
                                    ],
                                  )),
                                  Container(
                                    height: 35,
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Icon(Icons.subtitles_outlined),
                                      Text(estate.rentOrSale.toString() == "0.0"
                                          ? "بيع"
                                          : "اجار")
                                    ],
                                  )),
                                  Container(
                                    height: 35,
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                  estate.rentOrSale.toString() == "1.0"
                                      ? Expanded(
                                          child: Column(
                                          children: [
                                            Icon(Icons.timer),
                                            Text(estate.numberMonth.toString())
                                          ],
                                        ))
                                      : Expanded(child: Container())
                                ],
                              ),
                              //end last row

                              //start Specifications realEstate
                              SizedBox(height: 30),
                              Text("وصف العقار",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey)),
                              Text(estate.locationDescription,
                                  style: TextStyle(
                                    fontSize: 23,
                                  )),
                              //end Specifications realEstate

                              // start Coordinates
                              SizedBox(height: 30),
                              Text("احداثيات العقار",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey)),
                              SizedBox(height: 10),
                              // start google map
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black,
                                ),
                                child: GoogleMap(
                                  onMapCreated: (controller) {
                                    setState(() {
                                      mapController = controller;
                                    });
                                  },
                                  markers: marker.toSet(),
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        estate.xLatitude, estate.yLongitude),
                                    zoom: 16,
                                  ),
                                  mapType: MapType.hybrid,
                                ),
                              ),
                              // end google map
                              // end Coordinates

                              //start phone number
                              SizedBox(height: 30),
                              Text("رقم هاتف",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey)),
                              Text("$phoneNumber",
                                  style: TextStyle(fontSize: 20)),
                              SizedBox(height: 30),
                              //end phone number
                              estate.userId != user.id ?
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue[300])),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NewOffer(
                                                    realEstate: widget.estate,
                                                    user: user,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("اضافة عرض",
                                              style: TextStyle(fontSize: 20)),
                                          SizedBox(width: 5),
                                          Icon(Icons.add, size: 25),
                                        ],
                                      ),
                                    )),
                              )
                              :
                              Container()
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
