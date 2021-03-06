import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/api/areaAPI.dart';
import 'package:real_estate/api/cityAPI.dart';
import 'package:real_estate/api/realEstateAPI.dart';
import 'package:real_estate/api/registryAPI.dart';
import 'package:real_estate/api/typeAPI.dart';
import 'package:real_estate/models/AreaModel.dart';
import 'package:real_estate/models/CityModel.dart';
import 'package:real_estate/models/RealTypeModel.dart';
import 'package:real_estate/models/RegisterModel.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:real_estate/services/auth.dart';
import 'package:real_estate/screens/map/address.dart';
import 'package:real_estate/models/UserModel.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

class AddNewReal extends StatefulWidget {
  AddNewReal({Key key}) : super(key: key);
  @override
  _AddNewRealState createState() => _AddNewRealState();
}

class _AddNewRealState extends State<AddNewReal> {
  TextEditingController _priceController = TextEditingController();
  TextEditingController _spaceController = TextEditingController();
  TextEditingController _numberMounthController = TextEditingController();
  TextEditingController _spiesificationController = TextEditingController();
  TextEditingController _numberOfRoomController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<bool> isSelected;
  int rentOrSale = 0;
  int selectCityid = 0;
  bool changeEnaldeAndDesabel = false;

  //url
  List<City> cities;
  List<Area> areas;
  List<RealType> types;
  List<Register> registers;

  City selectCity;
  Area selectArea;
  RealType selectType;
  Register selectRegister;
  User user;

  //image
  List<Asset> images = [];
  List<dynamic> files = [];

  //list story home
  String nameStoryHome;
  List storyHome = ['???????? ????????????', '??????', '????????', '???? ??????'];

  //slider widget number of room
  int numberOfRoom = 25;

  //land
  int _bear;
  int _inviolable;
  int _roomLand;

  //shop
  int _roofShed;

  //map
  LatLng positioned;

  //flutter_easyLoding
  Timer _timer;

  @override
  void initState() {
    super.initState();
    // this is for 3 buttons, add "false" same as the number of buttons here
    isSelected = [true, false];
    getCities();
    getArea(idCity: selectCityid);
    getType();
    getRegister();
    this._bear = 2;
    this._inviolable = 2;
    this._roomLand = 2;
    this._roofShed = 2;
    this.user = Provider.of<Auth>(context, listen: false).user;
    //flutter_easyLoading
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }
  // -------------------------------------- START GET ALL URL ------------------

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

  // -------------------------------------- END GET ALL URL --------------------

  //--------------------------------------- START ALL WIDGET -------------------

  //return map for card
  returnMap(int typeHome, Map home, Map shop, Map land) {
    if (typeHome == 1) {
      return home;
    } else if (typeHome == 2) {
      return shop;
    } else {
      return land;
    }
  }

  // widget rent or sale
  Widget _rentOrSaleWidget() {
    return ToggleButtons(
      children: [
        // first toggle button
        Container(
          width: 150,
          child: Text(
            '??????',
            textAlign: TextAlign.center,
          ),
        ),
        // second toggle button
        Container(
          width: 150,
          child: Text(
            '????????',
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
    );
  }

  //price
  Widget _buildPrice() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 18),
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(hintText: "??????????"),
        keyboardType: TextInputType.number,
        controller: _priceController,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value.isEmpty) {
            return '?????????? ??????????';
          } else if (value.length < 7) {
            return '?????????? ??????????';
          } else if (value.length > 10) {
            return "?????????? ??????????";
          }
          return null;
        },
      ),
    );
  }

  // space
  Widget _buildSpace() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 18),
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(hintText: "??????????????"),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: _spaceController,
        validator: (String value) {
          if (value.isEmpty) {
            return '?????????????? ??????????';
          } else if (value.length < 2) {
            return "?????????????? ??????????";
          } else if (value.length > 3) {
            return "?????????????? ??????????";
          }
          return null;
        },
      ),
    );
  }

  //number mounth
  Widget _buildNumberMounth() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 18),
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(hintText: "?????? ????????????"),
        keyboardType: TextInputType.number,
        controller: _numberMounthController,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (String value) {
          if (value.isEmpty) {
            return '?????? ???????????? ??????????';
          }
          return null;
        },
      ),
    );
  }

  //Spiesificatio
  Widget _buildSpiesification() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 18),
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(hintText: "?????? ????????????"),
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        maxLength: 1000,
        controller: _spiesificationController,
        validator: (String value) {
          if (value.isEmpty) {
            return '?????????????? ??????????';
          }
          return null;
        },
      ),
    );
  }

  // coordinates ????????????????
  Widget _coordinates() {
    return FloatingActionButton(
        onPressed: () async {
          positioned = await Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new AddressMap()));
        },
        backgroundColor:
            this.positioned == null ? Colors.red : Colors.blue[300],
        child: Icon(Icons.add_location_alt_outlined));
  }

  getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }

  submit() async {
    files = [];
    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        var path2 =
            await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
        var file = await getImageFileFromAsset(path2);
        var base64Image =
            "data:image/jpeg;base64," + base64Encode(file.readAsBytesSync());
        files.add(base64Image);
      }
    }
  }

  Widget _buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      images = resultList;
      submit();
    });
  }

  //button image
  Widget _buttonSelectImage() {
    return FloatingActionButton(
        backgroundColor: images.isEmpty ? Colors.red : Colors.blue[300],
        child: Icon(Icons.add_a_photo_outlined),
        onPressed: loadAssets);
  }
  // end button image

  //----------------------------------------- start spcification widget home ---

  // livery ???????? ??????????

  Widget _storyHome() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 30),
      width: 350,
      child: DropdownButtonFormField(
          value: nameStoryHome,
          iconSize: 24,
          elevation: 16,
          isExpanded: true,
          items: storyHome?.map((storyHome) {
                return DropdownMenuItem(
                  value: storyHome,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        storyHome,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              })?.toList() ??
              [],
          hint: Text(
            "???????????? ???????? ????????????",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          validator: (value) => value == null ? "???????????? ??????????" : null,
          onChanged: (value) {
            setState(() {
              this.nameStoryHome = value;
            });
          }),
    );
  }

  //number of room ?????? ??????????
  Widget _buildNumberOfRoom() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 18),
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(hintText: "?????? ??????????"),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        controller: _numberOfRoomController,
        validator: (String value) {
          if (value.isEmpty) {
            return '?????? ?????????? ??????????';
          } else if (value.length > 20) {
            return '?????? ?????????? ????????';
          }
          return null;
        },
      ),
    );
  }

  //----------------------------------------- end spcification widget home -----

  //----------------------------------------- start spcification widget land ---

  //bear ?????? ??????
  selectButtoncheckBear(val) {
    setState(() {
      this._bear = val;
    });
  }

  Widget _buildRadioButtonbear() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Align(
              alignment: Alignment.topRight,
              child: Text("?????? ??????",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17),
                  textAlign: TextAlign.right)),
          Row(
            children: [
              Text("??????",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17)),
              Radio(
                  value: 1,
                  groupValue: _bear,
                  activeColor: Colors.blue[300],
                  onChanged: (val) {
                    setState(() {
                      selectButtoncheckBear(val);
                    });
                  }),
              Text("????",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17)),
              Radio(
                  value: 2,
                  groupValue: _bear,
                  activeColor: Colors.blue[300],
                  onChanged: (val) {
                    setState(() {
                      selectButtoncheckBear(val);
                    });
                  })
            ],
          ),
        ]));
  }

  //inviolable ??????????
  selectButtoncheckInviolable(val) {
    setState(() {
      this._inviolable = val;
    });
  }

  Widget _buildRadioButtoninviolable() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Align(
              alignment: Alignment.topRight,
              child: Text("??????????",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17),
                  textAlign: TextAlign.right)),
          Row(
            children: [
              Text("??????",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17)),
              Radio(
                  value: 1,
                  groupValue: _inviolable,
                  activeColor: Colors.blue[300],
                  onChanged: (val) {
                    setState(() {
                      selectButtoncheckInviolable(val);
                    });
                  }),
              Text("????",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17)),
              Radio(
                  value: 2,
                  groupValue: _inviolable,
                  activeColor: Colors.blue[300],
                  onChanged: (val) {
                    setState(() {
                      selectButtoncheckInviolable(val);
                    });
                  })
            ],
          ),
        ]));
  }

  //room ????????
  selectButtoncheckRoom(val) {
    setState(() {
      this._roomLand = val;
    });
  }

  Widget _buildRadioButtonRoom() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Align(
              alignment: Alignment.topRight,
              child: Text("????????",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17),
                  textAlign: TextAlign.right)),
          Row(
            children: [
              Text("??????",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17)),
              Radio(
                  value: 1,
                  groupValue: _roomLand,
                  activeColor: Colors.blue[300],
                  onChanged: (val) {
                    setState(() {
                      selectButtoncheckRoom(val);
                    });
                  }),
              Text("????",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17)),
              Radio(
                  value: 2,
                  groupValue: _roomLand,
                  activeColor: Colors.blue[300],
                  onChanged: (val) {
                    setState(() {
                      selectButtoncheckRoom(val);
                    });
                  })
            ],
          ),
        ]));
  }

  //----------------------------------------- end spcification widget land -----
  //----------------------------------------- start spcification widget shop ---
  //roof shed ??????????
  selectButtoncheckRoofShed(val) {
    setState(() {
      this._roofShed = val;
    });
  }

  Widget _buildRadioButtonRoofShed() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Align(
              alignment: Alignment.topRight,
              child: Text("?????????? ??????",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17),
                  textAlign: TextAlign.right)),
          Row(
            children: [
              Text("??????",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17)),
              Radio(
                  value: 1,
                  groupValue: _roofShed,
                  activeColor: Colors.blue[300],
                  onChanged: (val) {
                    setState(() {
                      selectButtoncheckRoofShed(val);
                    });
                  }),
              Text("????",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17)),
              Radio(
                  value: 2,
                  groupValue: _roofShed,
                  activeColor: Colors.blue[300],
                  onChanged: (val) {
                    setState(() {
                      selectButtoncheckRoofShed(val);
                    });
                  })
            ],
          ),
        ]));
  }

  //start send data to http and add new real estate
  saveData({Map card}) async {
    var formdata = _formKey.currentState;
    if (formdata.validate()) {
    } else {}
  }
  //end send data to http and add new real estate

  //----------------------------------------- end spcification widget shop -----
  Widget specifications() {
    return Column(
      children: [
        _buildPrice(),
        rentOrSale == 1 ? _buildNumberMounth() : Container(),
        _buildSpace(),
        _buildSpiesification(),
      ],
    );
  }

  Widget specificationsHome() {
    return Column(
      children: [
        _storyHome(),
        _buildNumberOfRoom(),
        specifications(),
      ],
    );
  }

  Widget specificationsShop() {
    return Column(
      children: [
        specifications(),
        SizedBox(
          height: 15,
        ),
        _buildRadioButtonRoofShed()
      ],
    );
  }

  Widget specificationsLand() {
    return Column(
      children: [
        specifications(),
        SizedBox(
          height: 15,
        ),
        _buildRadioButtonbear(),
        _buildRadioButtonRoom(),
        _buildRadioButtoninviolable(),
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

  //---------------------------------------- END ALL WIDGET --------------------

  //----------------------------------------- start send information -----------
  sendInformation({Map card, int idUser}) {
    int iduser = Provider.of<Auth>(context, listen: false).user.id;
    if (_formKey.currentState.validate()) {
      EasyLoading.show(status: '... ?????????? ??????????');
      RealEstateAPI realEstateAPI = new RealEstateAPI();
      realEstateAPI.addNewRealEstate(idUser: iduser, card: card);
      EasyLoading.showSuccess('???? ?????????? ???????????????? ??????????');
      Timer(Duration(seconds: 1), () {
        Navigator.pop(context, true);
      });
    }
  }

  //----------------------------------------- start send information -----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 50, right: 20, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //rent or sale
                        _rentOrSaleWidget(),
                        //-------------------------------------------start dropdown city
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
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      );
                                    })?.toList() ??
                                    [],
                                hint: Text(
                                  "???????????? ???????? ????????????????",
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
                                  });
                                }),
                          ),
                        ),
                        //end DropdownButton city
                        //------------------------------------ start dropdown area
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
                                        "???????????? ???????? ??????????????",
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
                        //end dropdown area
                        //-------------------------------- start dropdown register
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
                                      items: registers
                                              ?.map((Register register) {
                                            return DropdownMenuItem<Register>(
                                              value: register,
                                              child: Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    register.name,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            );
                                          })?.toList() ??
                                          [],
                                      hint: Text(
                                        "???????????? ?????? ?????? ????????????",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          this.selectRegister = value;
                                        });
                                      }),
                                ),
                              )
                            : Container(),
                        // end dropdown register
                        //------------------------------------ start dropdown type
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
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            );
                                          })?.toList() ??
                                          [],
                                      hint: Text(
                                        "???????????? ???????? ?????? ????????????",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          this.selectType = value;
                                        });
                                      }),
                                ),
                              )
                            : Container(),
                        //end DropdownButton type
                        //start Display the distinctive property specifications
                        specificationsFinal(),
                        SizedBox(
                          height: 10,
                        ),
                        // //end Display the distinctive property specifications
                        // start view all image
                        selectType != null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 20, bottom: 20),
                                child: SizedBox(
                                  height: images.isEmpty ? 0 : 150,
                                  width: MediaQuery.of(context).size.width,
                                  child: _buildGridView(),
                                ),
                              )
                            : Container(),
                        // end view all image

                        selectType != null
                            ?
                            // submit
                            FlatButton(
                                padding: EdgeInsets.all(10.0),
                                minWidth: double.infinity,
                                color: Colors.blue[300],
                                child: Container(
                                    child: Text("??????",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20))),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                onPressed: () {
                                  Map cardHome = {
                                    'livery': nameStoryHome,
                                    'number_of_room':
                                        _numberOfRoomController.text
                                  };
                                  Map cardLand = {
                                    'bear': _bear,
                                    'inviolable': _inviolable,
                                    'room': _roomLand,
                                  };
                                  Map cardShop = {'roof_shed': _roofShed};
                                  Map cards = {
                                    'rent_or_sale': rentOrSale,
                                    'space': int.parse(_spaceController.text),
                                    'price': int.parse(_priceController.text),
                                    'location_description':
                                        _spiesificationController.text,
                                    'area_id': selectArea.id,
                                    'realEstateRegistry_id': selectRegister.id,
                                    'realEstateType_id': selectType.id,
                                    'user_id': user.id,
                                    'number_month':
                                        _numberMounthController.text,
                                    'Specifications': returnMap(selectType.id,
                                        cardHome, cardShop, cardLand),
                                    'x_latitude': positioned.latitude,
                                    'y_longitude': positioned.longitude,
                                    'images': files,
                                  };
                                  if (images.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          Future.delayed(Duration(seconds: 5),
                                              () {
                                            Navigator.of(context).pop(true);
                                          });
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: AlertDialog(
                                              content: Icon(Icons.warning),
                                              title: Text(
                                                  '???????????? ???????? ?????? ????????????'),
                                            ),
                                          );
                                        });
                                  } else {
                                    sendInformation(card: cards);
                                  }
                                },
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
              selectType != null
                  ? Positioned(
                      bottom: 20,
                      left: 10,
                      child: Column(
                        children: [
                          _coordinates(),
                          SizedBox(height: 10),
                          _buttonSelectImage(),
                        ],
                      ))
                  : Container()
            ],
          )),
    );
  }
}