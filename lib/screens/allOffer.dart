import 'package:flutter/material.dart';
import 'package:real_estate/api/offerApi.dart';
import 'package:real_estate/models/OfferModel.dart';

class AllOffer extends StatefulWidget {
  int idEstate;
  AllOffer({this.idEstate});

  @override
  _AllOfferState createState() => _AllOfferState();
}

class _AllOfferState extends State<AllOffer> {
  int idEstate;
  getAllOffer({int idEstate}) async {
    OfferApi offerApi = new OfferApi();
    List<Offer> offers = await offerApi.allOffer(idEstate: idEstate);
    return offers;
  }

  @override
  void initState() {
    super.initState();
    idEstate = widget.idEstate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, top: 60, right: 20),
        child: FutureBuilder(
            future: getAllOffer(idEstate: this.idEstate),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              }
              List<Offer> offers = snapshot.data ?? [];
              return ListView.builder(
                  itemCount: offers.length,
                  itemBuilder: (context, index) {
                    Offer offer = offers[index];
                    return Container(
                        child: offers.isEmpty
                            ? Center(
                                child: Text(
                                "لم تقم بتزيل اي عقار بعد",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ))
                            : Container(
                                padding: EdgeInsets.only(right: 10,top: 10,left: 10,bottom: 10),
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(bottom: 35),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10)),
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
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(offer.user.name),
                                            Text(offer.user.email),
                                            Text(offer.user.phone.toString()),
                                          ],
                                        ),
                                        SizedBox(width: 10),
                                        Icon(Icons.person,color: Colors.blue,),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    Text(offer.description)
                                  ],
                                )));
                  });
            }));
  }
}
