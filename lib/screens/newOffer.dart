import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:real_estate/api/offerApi.dart';
import 'package:real_estate/models/RealEstateModel.dart';
import 'package:real_estate/models/UserModel.dart';

class NewOffer extends StatefulWidget {
  User user;
  RealEstate realEstate;

  NewOffer({this.user, this.realEstate});

  @override
  _NewOfferState createState() => _NewOfferState();
}

class _NewOfferState extends State<NewOffer> {
  TextEditingController _offerController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //flutter_easyLoding
  Timer _timer;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  //Email
  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          labelText: 'العرض',
          prefixIcon: Icon(Icons.local_offer_outlined)),
      maxLength: 50,
      maxLines: 3,
      controller: _offerController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'يجب ملئ الحقل';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool test = false;

    sendOffer({Map card}) async {
      if (_formKey.currentState.validate()) {
        EasyLoading.show(status: '... انتظر قليلا');
        OfferApi offerApi = new OfferApi();
        test = await offerApi.saveOffer(card: card);
        EasyLoading.showSuccess('تم تحميل البيانات بنجاح');
        Timer(Duration(seconds: 1), () {
          Navigator.pop(context, true);
        });
      }
    }

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildEmail(), flex: 5),
                Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        child: Icon(Icons.send),
                        onPressed: () {
                          Map card = {
                            "description": _offerController.text,
                            "user_id": widget.user.id,
                            "estate_id": widget.realEstate.id,
                          };
                          print({"card offer ": card});
                          sendOffer(card: card);
                        })),
              ],
            )
          ],
        ),
      ),
    );
  }
}
