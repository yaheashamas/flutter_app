import 'dart:async';
import 'package:flutter/material.dart';
import 'package:real_estate/api/areaAPI.dart';
import 'package:real_estate/api/cityAPI.dart';
import 'package:real_estate/api/realEstateAPI.dart';
import 'package:real_estate/models/AreaModel.dart';
import 'package:real_estate/models/CityModel.dart';
import 'package:chips_choice/chips_choice.dart';

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
  int tag = 1;
  List<String> options = ['شراء', 'اجار'];

  final _formKey = GlobalKey<FormState>();
  TextEditingController _numberLow = TextEditingController();
  TextEditingController _numberHit = TextEditingController();
  bool _validateLow = false;
  bool _validateHit = false;

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
    RealEstateAPI realEstateAPI = new RealEstateAPI();
    return await realEstateAPI.search(card: card);
  }

  @override
  void initState() {
    super.initState();
    getAllCities();
    getArea(idCity: selectCityid);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
      child: Form(
        key: _formKey,
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
                        offset: Offset(0, 3), // changes position of shadow
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
                                print({"tag": tag}),
                              }),
                          choiceItems: C2Choice.listFrom<int, String>(
                            source: options,
                            value: (i, v) => i,
                            label: (i, v) => v,
                          ),
                        ),
                        // end sesstion chose if sall or rent

                        // start sesstion citiy
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: IgnorePointer(
                                ignoring: changeEnaldeAndDesabel,
                                    child: DropdownButton(
                                    value: selectCity,
                                    isExpanded: true,
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
                                                      color: Colors.black),
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
                                        getArea(idCity: this.selectCityid);
                                        print({"selectCity": selectCity});
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
                            ? Container(
                                margin: EdgeInsets.only(left: 20, top: 20),
                                width: 350,
                                child: IgnorePointer(
                                  ignoring: false,
                                  child: DropdownButton(
                                      value: selectArea,
                                      iconSize: 24,
                                      elevation: 16,
                                      isExpanded: true,
                                      items: areas?.map((Area area) {
                                            return DropdownMenuItem<Area>(
                                              value: area,
                                              child: Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    area.name,
                                                    style: TextStyle(
                                                        color: Colors.black),
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          this.selectArea = value;

                                        });
                                      }),
                                ),
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
                                    MaterialStateProperty.all(Colors.blue)),
                            onPressed: () {
                              this.sheapPageSearch = false;
                              setState(() {
                                Map card = {
                                  'rentOrSeal': this.tag,
                                  'city': this.selectCity.name,
                                  'lowPrice': this._numberLow.text,
                                  'hitPrice': this._numberHit.text
                                };
                                if (_formKey.currentState.validate()) {
                                  functionSearch(card: card);
                                }
                              });
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
    );
  }
}
