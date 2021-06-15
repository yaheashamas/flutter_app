import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/api/realEstateAPI.dart';
import 'package:real_estate/models/RealEstateModel.dart';
import "package:image/src/image.dart" as im;
import 'package:real_estate/screens/allOffer.dart';

class MyRealEstate extends StatefulWidget {
  int idUser;
  MyRealEstate({this.idUser});

  @override
  _MyRealEstateState createState() => _MyRealEstateState();
}

class _MyRealEstateState extends State<MyRealEstate> {
  List<RealEstate> realEstate = [];

  getAllRealEstateForSpicalUser({int id}) async {
    RealEstateAPI realEstateAPI = new RealEstateAPI();
    List<RealEstate> realEstate =
        await realEstateAPI.getAllRealEstateForUser(id: id);
    return realEstate;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllRealEstateForSpicalUser(id: widget.idUser),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<RealEstate> estates = snapshot.data ?? [];
            return Container(
                child: estates.isEmpty
                    ? Center(
                        child: Text(
                        "لم تقم بتزيل اي عقار بعد",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                    : Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 40, right: 20),
                        child: ListView.builder(
                            itemCount: estates.length,
                            itemBuilder: (context, index) {
                              RealEstate estate = estates[index];
                              return Container(
                                  padding: EdgeInsets.only(right: 10),
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(bottom: 35),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          child:
                                              //start image
                                              ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            child: CachedNetworkImage(
                                              width: double.infinity,
                                              imageUrl: estate.images[0].url,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          //end image
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            estate.area.city.name,
                                          ),
                                          Text(
                                            estate.area.name,
                                          ),
                                          Text(estate.realEstateTypeId == 1
                                              ? "بيت"
                                              : "محل"),
                                          Text(estate.rentOrSale == 1
                                              ? "اجار"
                                              : "بيع")
                                        ],
                                      )),
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: TextButton(
                                                style: TextButton.styleFrom(
                                                  primary: Colors.white,
                                                  backgroundColor: Colors.teal,
                                                  onSurface: Colors.grey,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AllOffer(
                                                                  idEstate: estate
                                                                      .id)));
                                                },
                                                child: Text("العروض")),
                                          )),
                                    ],
                                  ));
                            }),
                      ));
          }
        });
  }
}

//  Expanded(
//                                   flex: 2,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment
//                                                 .spaceBetween,
//                                         children: [
//                                           Text(
//                                             estate.area.city.name,
//                                           ),
//                                           Text(
//                                             estate.area.name,
//                                           )
//                                         ],
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment
//                                                 .spaceBetween,
//                                         children: [
//                                           Text(
//                                               estate.realEstateTypeId == 1
//                                                   ? "بيت"
//                                                   : "محل"),
//                                           Text(estate.rentOrSale == 1
//                                               ? "اجار"
//                                               : "بيع")
//                                         ],
//                                       ),
//                                       TextButton(
//                                           style: TextButton.styleFrom(
//                                             primary: Colors.white,
//                                             backgroundColor: Colors.teal,
//                                             onSurface: Colors.grey,
//                                           ),
//                                           onPressed: () {
//                                             Navigator.of(context).push(
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         AllOffer(
//                                                             idEstate:
//                                                                 estate
//                                                                     .id)));
//                                           },
//                                           child: Text("العروض"))
//                                     ],
//                                   ),
//                                 )
