import 'dart:io';
import 'package:flutter/material.dart';
import 'package:real_estate/api/areaAPI.dart';
import 'package:real_estate/api/cityAPI.dart';
import 'package:real_estate/api/registryAPI.dart';
import 'package:real_estate/api/typeAPI.dart';
import 'package:real_estate/models/AreaModel.dart';
import 'package:real_estate/models/CityModel.dart';
import 'package:real_estate/models/RealTypeModel.dart';
import 'package:real_estate/models/RegisterModel.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddNewReal extends StatefulWidget {
  AddNewReal({Key key}) : super(key: key);
  @override
  _AddNewRealState createState() => _AddNewRealState();
}

class _AddNewRealState extends State<AddNewReal> {
  TextEditingController _PriceController = TextEditingController();
  TextEditingController _SpaceController = TextEditingController();
  TextEditingController _NumberMounthController = TextEditingController();
  TextEditingController _SpiesificationController = TextEditingController();
  TextEditingController _NumberOfRoomController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //this key for all this page
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<bool> isSelected;
  int rentOrSale;
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

  //image
  List<Asset> images = [];

  //list story home
  String nameStoryHome;
  List storyHome = ['سوبر ديلوكس', 'جيد', 'عادي', 'عل عضم'];

  //slider widget number of room
  int numberOfRoom = 25;

  //load
  int _bear;
  int _inviolable;
  int _roomLand;

  //shop
  int _roofShed;

  @override
  void initState() {
    super.initState();
    // this is for 3 buttons, add "false" same as the number of buttons here
    isSelected = [true, false];
    getCities();
    getArea(idCity: selectCityid);
    getType();
    getRegister();
    this._bear = 0;
    this._inviolable = 0;
    this._roomLand = 0;
    this._roofShed = 0;
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

  // widget rent or sale
  Widget _rentOrSaleWidget() {
    return ToggleButtons(
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
    );
  }

  //price
  Widget _buildPrice() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 18),
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(hintText: "السعر"),
        keyboardType: TextInputType.number,
        controller: _PriceController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'السعر مطلوب';
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
        decoration: InputDecoration(hintText: "المساحة"),
        keyboardType: TextInputType.number,
        controller: _SpaceController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'المساحة مطلوب';
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

  //Spiesificatio
  Widget _buildSpiesification() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 18),
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(hintText: "ملاحظات"),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: _SpiesificationController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'ملاحظات مطلوب';
          }
          return null;
        },
      ),
    );
  }

  // coordinates الاحداثيات
  Widget _coordinates() {
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text("الاحداثيات",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17)),
            )),
        Container(
          margin: EdgeInsets.only(left: 20, top: 20),
          width: 350,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
        ),
      ],
    );
  }

  //start widget Image
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
    });
  }

  //button image
  Widget _buttonSelectImage() {
    return FloatingActionButton(
        backgroundColor: Colors.blue[300],
        child: Icon(Icons.camera_alt_outlined),
        onPressed: loadAssets);
  }
  // end widget image

  //----------------------------------------- start spcification widget home ---

  // livery كسوة البيت

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
            "الرجاء اختر الكسوة",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          validator: (value) => value == null ? "الكسوة مطلوب" : null,
          onChanged: (value) {
            setState(() {
              this.nameStoryHome = value;
            });
          }),
    );
  }

  //number of room عدد الغرف
  Widget _buildNumberOfRoom() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 18),
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(hintText: "عدد الغرف"),
        keyboardType: TextInputType.number,
        controller: _NumberOfRoomController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'عدد الغرف مطلوب';
          }
          return null;
        },
      ),
    );
  }

  //----------------------------------------- end spcification widget home -----

  //----------------------------------------- start spcification widget land ---

  //bear بير ماء
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
              child: Text("بير ماء",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17),
                  textAlign: TextAlign.right)),
          Row(
            children: [
              Text("نعم",
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
              Text("لا",
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

  //inviolable مصونة
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
              child: Text("مصونة",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17),
                  textAlign: TextAlign.right)),
          Row(
            children: [
              Text("نعم",
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
              Text("لا",
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

  //room مسكن
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
              child: Text("مسكن",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17),
                  textAlign: TextAlign.right)),
          Row(
            children: [
              Text("نعم",
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
              Text("لا",
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
  //roof shed سقيفة
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
              child: Text("سئيفة محل",
                  style: TextStyle(color: Colors.grey[700], fontSize: 17),
                  textAlign: TextAlign.right)),
          Row(
            children: [
              Text("نعم",
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
              Text("لا",
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
                                        "الرجاء اخر نوع الطابو",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          this.selectRegister = value;
                                          print({
                                            "selectRegister": selectRegister
                                          });
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
                                        "الرجاء اختر نوع العقار",
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
                        selectType != null ? _coordinates() : Container(),

                        SizedBox(
                          height: 10,
                        ),
                        // //end Display the distinctive property specifications
                        // start view all image
                        selectType != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, left: 20),
                                child: SizedBox(
                                  height: images.isEmpty ? 0 : 300,
                                  width: MediaQuery.of(context).size.width,
                                  child: _buildGridView(),
                                ),
                              )
                            : Container(),
                        // end view all image

                        // submit
                        FlatButton(
                          padding: EdgeInsets.all(10.0),
                          minWidth: double.infinity,
                          color: Colors.blue[300],
                          child: Container(
                              child: Text("حفظ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20))),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing Data')));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              selectType != null
                  ? Positioned(
                      bottom: 20, left: 10, child: _buttonSelectImage())
                  : Container()
            ],
          )),
    );
  }
}
