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
                  //start container image
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                    child: realEstate.images.isEmpty ?
                    Image.asset('images/real.png',fit: BoxFit.cover,)
                    :
                    CachedNetworkImage(
                      width: double.infinity,
                      imageUrl: realEstate.images[0].url,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  //end container image

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
                                Icon(Icons.my_library_books_outlined),
                                Text(realEstate.register.name),
                              ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(realEstate.realType.code == "HOME" ? Icons.home_outlined : Icons.shop),
                                Text(realEstate.realType.name)
                              ],
                            ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Icon(Icons.location_on_outlined),
                                Flexible(child: Text(realEstate.area.name,))
                              ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_city_rounded),
                                Text(realEstate.area.city.name)
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
