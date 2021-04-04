import 'package:flutter/material.dart';
import 'package:real_estate/api/areaAPI.dart';
import 'package:real_estate/api/cityAPI.dart';
import 'package:real_estate/api/registryAPI.dart';
import 'package:real_estate/api/typeAPI.dart';
import 'package:real_estate/models/AreaModel.dart';
import 'package:real_estate/models/CityModel.dart';
import 'package:real_estate/models/RealTypeModel.dart';
import 'package:real_estate/models/RegisterModel.dart';

class AddNewReal extends StatefulWidget {
  AddNewReal({Key key}) : super(key: key);

  @override
  _AddNewRealState createState() => _AddNewRealState();
}

class _AddNewRealState extends State<AddNewReal> {
  TextEditingController _PriceController = TextEditingController();
  TextEditingController _SpaceController = TextEditingController();
  TextEditingController _NumberMounthController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<bool> isSelected;
  int rentOrSale;
  int selectCityid = 0;
  bool changeEnaldeAndDesabel = false;

  List<City> cities;
  List<Area> areas;
  List<RealType> types;
  List<Register> registers;

  City selectCity;
  Area selectArea;
  RealType selectType;
  Register selectRegister;

  @override
  void initState() {
    // this is for 3 buttons, add "false" same as the number of buttons here
    isSelected = [true, false];
    getCities();
    getArea(idCity: selectCityid);
    getType();
    getRegister();
    super.initState();
  }

  //all cities
  getCities() async {
    CityAPI cityAPI = new CityAPI();
    List<City> citiesResponse = await cityAPI.getAllCities();
    setState(() {
      cities = citiesResponse;
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

  //all type realEstate
  getType() async {
    TypeAPI typeAPI = new TypeAPI();
    List<RealType> typeRespone = await typeAPI.getAllType();
    setState(() {
      types = typeRespone;
    });
  }

  //get register
  getRegister() async {
    RegistryAPI registryAPI = new RegistryAPI();
    List<Register> registerResponse = await registryAPI.getAllRegistry();
    setState(() {
      registers = registerResponse;
    });
  }

  Widget _buildPrice() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 18),
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(hintText: "السعر"),
        keyboardType: TextInputType.number,
        controller: _PriceController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'السعر مطلوب';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSpace() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 18),
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(hintText: "المساحة"),
        keyboardType: TextInputType.number,
        controller: _SpaceController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'المساحة مطلوبة';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildNumberMounth() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 18),
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(hintText: "عدد الاشهر"),
        keyboardType: TextInputType.number,
        controller: _NumberMounthController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'عدد الاشهر مطلوب';
          }
          return null;
        },
      ),
    );
  }

  Widget specifications() {
    return Column(
      children: [
        _buildPrice(),
        rentOrSale == 1 ? _buildNumberMounth() : Container(),
        _buildSpace(),
        Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,top: 20),
                child: Text("الاحداثيات"),
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 20,top: 20),
              width: 350,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20)
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget specificationsHome() {
    return Column(
      children: [
        specifications()
      ],
    );
  }

  Widget specificationsShop() {
    return Column(
      children: [
        specifications()
      ],
    );
  }

  Widget specificationsLand() {
    return Column(
      children: [
        specifications(),  
      ],
    );
  }

  Widget specificationsFinal() {
    if (selectType == null) {
      return Container();
    } else {
      if (selectType.code == "HOME") {
        return specificationsHome();
      } else if (selectType.code == "SHOP") {
        return specificationsShop();
      } else {
        return specificationsLand();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50,right: 20,left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ToggleButtons(
                children: [
                  // first toggle button
                  Container(
                    width: 150,
                    child: Text(
                      'بيع',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // second toggle button
                  Container(
                    width: 150,
                    child: Text(
                      'اجار',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                // logic for button selection below
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                      this.rentOrSale = index;
                    }
                  });
                },
                isSelected: isSelected,
              ),
              //start dropdown city
              Container(
                margin: EdgeInsets.only(left: 20, top: 30),
                width: 350,
                child: IgnorePointer(
                  ignoring: changeEnaldeAndDesabel,
                  child: DropdownButton(
                      value: selectCity,
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      items: cities?.map((City city) {
                            return DropdownMenuItem<City>(
                              value: city,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    city.name,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          })?.toList() ??
                          [],
                      hint: Text(
                        "الرجاء اختر المحافظة",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      onChanged: (value) {
                        setState(() {
                          this.selectCity = value;
                          this.selectCityid = selectCity.id;
                          changeEnaldeAndDesabel = true;
                          getArea(idCity: this.selectCityid);
                          print({"selectCity": selectCity});
                        });
                      }),
                ),
              ),
              //end DropdownButton city
              //start DropdownButton area
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
                                          style: TextStyle(color: Colors.black),
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
                                print({"selectArea": selectArea});
                              });
                            }),
                      ),
                    )
                  : Container(),
              //end DropdownButton area
              //Start DropdownButton register
              selectArea != null
                  ? Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      width: 350,
                      child: IgnorePointer(
                        ignoring: false,
                        child: DropdownButton(
                            value: selectRegister,
                            iconSize: 24,
                            elevation: 16,
                            isExpanded: true,
                            items: registers?.map((Register register) {
                                  return DropdownMenuItem<Register>(
                                    value: register,
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          register.name,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                })?.toList() ??
                                [],
                            hint: Text(
                              "الرجاء اخر نوع الطابو",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onChanged: (value) {
                              setState(() {
                                this.selectRegister = value;
                                print({"selectRegister": selectRegister});
                              });
                            }),
                      ),
                    )
                  : Container(),
              //Start DropdownButton register
              //Start DropdownButton type
              selectRegister != null
                  ? Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      width: 350,
                      child: IgnorePointer(
                        ignoring: false,
                        child: DropdownButton(
                            value: selectType,
                            iconSize: 24,
                            elevation: 16,
                            isExpanded: true,
                            items: types?.map((RealType realType) {
                                  return DropdownMenuItem<RealType>(
                                    value: realType,
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          realType.name,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  );
                                })?.toList() ??
                                [],
                            hint: Text(
                              "الرجاء اختر نوع العقار",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onChanged: (value) {
                              setState(() {
                                this.selectType = value;
                                // print({"selectType.code": selectType.code});
                              });
                            }),
                      ),
                    )
                  : Container(),
              //end DropdownButton type
              //start Display the distinctive property specifications
              specificationsFinal()
              // //end Display the distinctive property specifications
            ],
          ),
        ),
      ),
    );
  }
}
