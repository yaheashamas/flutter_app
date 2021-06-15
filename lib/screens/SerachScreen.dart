import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate/api/areaAPI.dart';
import 'package:real_estate/api/cityAPI.dart';
import 'package:real_estate/api/realEstateAPI.dart';
import 'package:real_estate/api/search.dart';
import 'package:real_estate/models/AreaModel.dart';
import 'package:real_estate/models/CityModel.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:real_estate/models/RealEstateModel.dart';
import 'package:real_estate/screens/card/RealEstateCard.dart';

class SearchScreen extends StatefulWidget {
  List<City> cities;
  SearchScreen({this.cities});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  List<City> allcities = [];
  List<Area> areas = [];

  City selectCity;
  Area selectArea;

  int selectCityid = 0;
  bool changeEnaldeAndDesabel = false;

  bool sheapPageSearch = true;
  // rent =>  0| sale => |
  int tag = 0;
  List<String> options = ['شراء', 'اجار'];

  //home => 1 | stor => 2 | land =>3
  int tagtype = 0;
  List<String> optionType = ['بيت', 'محل', 'ارض'];

  Map cardd = {};

  final _formKey = GlobalKey<FormState>();

  TextEditingController _numberLow = TextEditingController();
  TextEditingController _numberHit = TextEditingController();

  getAllCities() async {
    CityAPI cityAPI = new CityAPI();
    List<City> cities = await cityAPI.getAllCities();
    setState(() {
      allcities = cities;
    });
  }

  //all areas
  getArea({int idCity}) async {
    AreaAPi areaAPi = new AreaAPi();
    List<Area> areaResponse = await areaAPi.getAllArea(idCity: idCity);
    setState(() {
      areas = areaResponse;
    });
  }

  functionSearch({Map card}) async {
    List<RealEstate> allRealEstates = [];
    SearchApi searchApi = new SearchApi();
    allRealEstates = await searchApi.sreachAboutAllRealEstate(card: card);
    return allRealEstates;
  }

  @override
  void initState() {
    super.initState();
    getAllCities();
    getArea(idCity: selectCityid);
  }

  @override
  Widget build(BuildContext context) {
    return sheapPageSearch
        ? Padding(
            padding: const EdgeInsets.only(top: 150, right: 10, left: 10),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            children: [
                              // start sesstion chose if sall or rent
                              ChipsChoice<int>.single(
                                value: tag,
                                onChanged: (val) => setState(() => {
                                      tag = val,
                                    }),
                                choiceItems: C2Choice.listFrom<int, String>(
                                  source: options,
                                  value: (i, v) => i,
                                  label: (i, v) => v,
                                ),
                              ),
                              // end sesstion chose if sall or rent

                              // start sesstion chose if home or alnd or stor
                              ChipsChoice<int>.single(
                                value: tagtype,
                                onChanged: (val) => setState(() => {tagtype = val,
                                print(tagtype)}),
                                choiceItems: C2Choice.listFrom<int, String>(
                                  source: optionType,
                                  value: (i, v) => i,
                                  label: (i, v) => v,
                                ),
                              ),
                              // end sesstion chose if home or alnd or stor

                              // start sesstion citiy
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: IgnorePointer(
                                      ignoring: changeEnaldeAndDesabel,
                                      child: DropdownButtonFormField(
                                          value: selectCity,
                                          isExpanded: true,
                                          validator: (value) =>
                                              value == null ? 'مطلوب' : null,
                                          items: allcities?.map((City city) {
                                                return DropdownMenuItem<City>(
                                                  value: city,
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        city.name,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })?.toList() ??
                                              [],
                                          onChanged: (value) {
                                            setState(() {
                                              selectCity = value;
                                              this.selectCityid = selectCity.id;
                                              changeEnaldeAndDesabel = true;
                                              getArea(
                                                  idCity: this.selectCityid);
                                            });
                                          }),
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                    " : المحافظة",
                                    textAlign: TextAlign.center,
                                  )),
                                ],
                              ),
                              // end sesstion citiy

                              // start section area
                              selectCity != null
                                  ? Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: IgnorePointer(
                                            ignoring: false,
                                            child: DropdownButtonFormField(
                                                value: selectArea,
                                                iconSize: 24,
                                                elevation: 16,
                                                validator: (value) =>
                                                    value == null
                                                        ? 'مطلوب'
                                                        : null,
                                                isExpanded: true,
                                                items: areas?.map((Area area) {
                                                      return DropdownMenuItem<
                                                          Area>(
                                                        value: area,
                                                        child: Row(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              area.name,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    })?.toList() ??
                                                    [],
                                                hint: Text(
                                                  "الرجاء اختر المنطقة",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    this.selectArea = value;
                                                  });
                                                }),
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                          ": المدينة",
                                          textAlign: TextAlign.center,
                                        ))
                                      ],
                                    )
                                  : Container(),
                              // end sesstion area
                              // start sesstion price
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 65.0,
                                          child: Expanded(
                                              child: TextFormField(
                                            controller: _numberLow,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "مطلوب";
                                              } else if (value.length < 7) {
                                                return "السعر قليل";
                                              } else if (value.length > 10) {
                                                return "السعر مرفع";
                                              } else {
                                                return null;
                                              }
                                            },
                                          )),
                                        ),
                                        Text(" : الحد الادنى"),
                                        SizedBox(width: 20),
                                        Container(
                                          width: 65.0,
                                          child: Expanded(
                                              child: TextFormField(
                                            controller: _numberHit,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "مطلوب";
                                              } else if (value.length < 7) {
                                                return "السعر قليل";
                                              } else if (value.length > 10) {
                                                return "السعر مرفع";
                                              } else {
                                                return null;
                                              }
                                            },
                                          )),
                                        ),
                                        Text(" : الحد الاعظم"),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                    " : السعر",
                                    textAlign: TextAlign.center,
                                  ))
                                ],
                              ),
                              // end sesstion price
                              SizedBox(height: 10),
                              //start sesstion button to save ind send to api
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue)),
                                  onPressed: () {
                                    Map card = {
                                      'rent_or_sale': this.tag,
                                      'realEstateType_id':this.tagtype +1,
                                      'area_id': this.selectArea.id,
                                      'min_price': this._numberLow.text,
                                      'max_price': this._numberHit.text
                                    };
                                    cardd = card;
                                    print({"card ===>": card});
                                    if (_formKey.currentState.validate()) {
                                      functionSearch(card: card);
                                      this.sheapPageSearch = false;
                                      setState(() {});
                                    }
                                  },
                                  child: Text("بحث"))
                              //end sesstion button to save ind send to api
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : FutureBuilder(
            future: functionSearch(card: cardd),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              }
              List<RealEstate> estates = snapshot.data ?? [];
              return Stack(
                children: [
                  Container(
                      child: estates.isEmpty
                          ? Center(
                              child: Text(
                              "لا يوجد نتائج لعرضها",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ))
                          : ListView.builder(
                              itemCount: estates.length,
                              itemBuilder: (context, index) {
                                RealEstate estate = estates[index];
                                return RealEstateCard(realEstate: estate);
                              })),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: ClipOval(
                      child: Material(
                        color: Colors.blue[300], // Button color
                        child: InkWell(
                          splashColor: Colors.red, // Splash color
                          onTap: () {
                            setState(() {
                              sheapPageSearch = true;
                            });
                          },
                          child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(Icons.replay_sharp)),
                        ),
                      ),
                    ),
                  )
                ],
              );
            });
  }
}
