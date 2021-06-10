import 'package:flutter/material.dart';

class NewOffer extends StatefulWidget {
  NewOffer({Key key}) : super(key: key);

  @override
  _NewOfferState createState() => _NewOfferState();
}

class _NewOfferState extends State<NewOffer> {
  TextEditingController _offerController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    sendOffer() {
      if (_formKey.currentState.validate()) {}
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildEmail(), flex: 5),
                Expanded(
                    child:TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          child: Icon(Icons.send),
                          onPressed: () {
                            sendOffer();
                          })),
              ],
            )
          ],
        ),
      ),
    );
  }
}
