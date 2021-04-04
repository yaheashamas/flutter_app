import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/models/RealEstateModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:real_estate/services/auth.dart';

class DescRealEstateScreen extends StatefulWidget {
  final RealEstate estate;
  DescRealEstateScreen({this.estate});
  @override
  _DescRealEstateScreenState createState() => _DescRealEstateScreenState();
}

class _DescRealEstateScreenState extends State<DescRealEstateScreen> {
  // bool _favorate = true;
  RealEstate estate;
  List allUrlImages;
  int _current = 0;
  
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
  }

  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    double price = estate.price + .0;
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: price);
    Size size = MediaQuery.of(context).size;
    int phoneNumber = Provider.of<Auth>(context, listen: false).user.phone;

    return ChangeNotifierProvider(
      create: (context) {
        return Auth();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              Container(
                child: Stack(
                  children: [
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
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("السعر",
                                        style: TextStyle(fontSize: 20)),
                                    Text(fmf.output.withoutFractionDigits,
                                        style: TextStyle(
                                            fontSize: 23, color: Colors.grey)),
                                  ]),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 20),
                              child: Text(
                                "المواصفات",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            //start first row
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Icon(
                                        estate.realType.code == "HOME"
                                            ? Icons.home_outlined
                                            : Icons.shop,
                                        color: Colors.grey),
                                    Text(
                                      estate.realType.name,
                                      style: TextStyle(color: Colors.grey),
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
                                    Icon(Icons.location_pin,
                                        color: Colors.grey),
                                    Text(
                                      estate.area.name,
                                      style: TextStyle(color: Colors.grey),
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
                                    Icon(Icons.location_city,
                                        color: Colors.grey),
                                    Text(
                                      estate.area.city.name,
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                )),
                              ],
                            ),
                            //end first row
                            SizedBox(height: 30),
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
                                    Icon(Icons.architecture,
                                        color: Colors.grey),
                                    Text(
                                      estate.space.toString(),
                                      style: TextStyle(color: Colors.grey),
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
                                    Icon(Icons.location_pin,
                                        color: Colors.grey),
                                    Text(
                                      estate.rentOrSale.toString() == "1.0"
                                          ? "بيع"
                                          : "اجار",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                )),
                                Container(
                                  height: 35,
                                  width: 0.5,
                                  color: Colors.grey,
                                ),
                                estate.rentOrSale.toString() == "0.0"
                                    ? Expanded(
                                        child: Column(
                                        children: [
                                          Icon(Icons.calendar_today,
                                              color: Colors.grey),
                                          Text(
                                            estate.numberMonth.toString(),
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                        
                                      ))
                                    : Expanded(child: Container())
                              ],
                            ),
                            //end last row
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("وصف العقار",
                                        style: TextStyle(fontSize: 20)),
                                    Text(estate.locationDescription,
                                        style: TextStyle(
                                            fontSize: 23, color: Colors.grey)),
                                  ]),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("احداثيات العقار",
                                        style: TextStyle(fontSize: 20)),
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black,
                                      ),
                                    )
                                  ]),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("رقم الهاتف صاحب العقار",
                                      style: TextStyle(fontSize: 20)),
                                  SizedBox(height: 10),
                                  Text("$phoneNumber",
                                      style: TextStyle(fontSize: 20,color: Colors.grey))
                                ]),
                            ),
                          ],
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
