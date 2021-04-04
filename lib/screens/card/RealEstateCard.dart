import 'package:flutter/material.dart';
import 'package:real_estate/screens/DescRealEstateScreen.dart';
import '../../models/RealEstateModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

// ignore: must_be_immutable
class RealEstateCard extends StatelessWidget {

  bool favorate = false;
  RealEstate realEstate;
  RealEstateCard({this.realEstate});
  @override
  Widget build(BuildContext context) {
    double price = realEstate.price + .0;
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
    amount: price
    );
    return InkWell(
          child: Padding(
            padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 25),
            child: Card(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      imageUrl: realEstate.images[0].url,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10,left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [                           
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            fmf.output.withoutFractionDigits,
                            style: TextStyle(fontSize: 23, color: Colors.black)
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Icon(Icons.my_library_books_outlined, color: Colors.grey),
                                Text(realEstate.register.name,style: TextStyle(color: Colors.grey),),
                              ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(realEstate.realType.code == "HOME" ? Icons.home_outlined : Icons.shop, color: Colors.grey),
                                Text(realEstate.realType.name,style: TextStyle(color: Colors.grey),)
                              ],
                            ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Icon(Icons.location_pin,color: Colors.grey),
                                Text(realEstate.area.name,style: TextStyle(color: Colors.grey),)
                              ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_city, color: Colors.grey),
                                Text(realEstate.area.city.name,style:TextStyle(color: Colors.grey),)
                              ],
                            ),
                            )
                          ],
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              )
            ),
          ),
          onTap: (){
            Navigator
            .of(context)
            .push(MaterialPageRoute(builder: 
            (context)=>DescRealEstateScreen(estate: realEstate)
            ));
          },
    );
  }
}
