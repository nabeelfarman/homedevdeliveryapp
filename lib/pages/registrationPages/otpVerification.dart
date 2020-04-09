import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:async';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/main.dart';

int _pin;

class OTPVerification extends StatefulWidget {
  final String mobileNumber;
  final String pwd;
  final int pin;

  OTPVerification({
    @required this.mobileNumber,
    @required this.pwd,
    @required this.pin,
  });

  _OTPVerification createState() => _OTPVerification(mobileNumber, pwd, pin);
}

class _OTPVerification extends State<OTPVerification> {
  String mobileNumber;
  String pwd;
  int pin;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProgressDialog pr;

  TextEditingController txtPin = new TextEditingController();

  _OTPVerification(
    this.mobileNumber,
    this.pwd,
    this.pin,
  );

  void validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  void checkPin() async {
    try {
      print(txtPin.text);
      print(pin);
      print(_pin);
      if (txtPin.text == '') {
        validateAndSave();
      } else {
        validateAndSave();
        int pins = int.parse(txtPin.text);
        if (_pin == null) {
          _pin = pin;
          if (pins == pin) {
            navigateToSupplier(context);
          } else {
            Widget okButton = FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            );
            AlertDialog alert = AlertDialog(
              title: Text("Error!"),
              content: Text('Invalid Pin'),
              actions: [
                okButton,
              ],
            );
            // show the dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          }
        } else {
          if (pins == _pin) {
            navigateToSupplier(context);
          } else {
            Widget okButton = FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            );
            AlertDialog alert = AlertDialog(
              title: Text("Error!"),
              content: Text('Invalid Pin'),
              actions: [
                okButton,
              ],
            );
            // show the dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          }
        }
      }
    } catch (e) {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text("Error!"),
        content: Text(e.toString()),
        actions: [
          okButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  void resendPin() async {
    try {
      String _code = "123";

      pr.show();

      http.Response response = await http.post(
        'http://95.217.147.105:2003/api/genotp',
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body:
            jsonEncode(<String, String>{'Cellno': mobileNumber, 'Code': _code}),
      );

      final Map responseJson = json.decode(response.body);
      _pin = responseJson['msg'];
      pr.hide();

      print(responseJson['msg']);
    } catch (e) {
      pr.hide();
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text("Error!"),
        content: Text(e.toString()),
        actions: [
          okButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //declarations
    Color blackClr = Color(0xff141622);
    Color greenClr = Color(0xff8cc540);
    Color blueClr = Color(0xff408cc5);
    Color bodyClr = Color(0xfff8f7f7);

    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
      message: 'Please Wait...',
      borderRadius: 10.0,
      backgroundColor: blackClr,
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(greenClr),
      ),
      elevation: 20.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: bodyClr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Material(
                elevation: 10,
                child: FadeAnimation(
                    1.0,
                    Container(
                      height: 80,
                      alignment: Alignment.bottomCenter,
                      color: blackClr,
                      child: Text(
                        'REGISTRATION',
                        style: TextStyle(
                            color: greenClr, fontSize: 40, fontFamily: 'Abel'),
                      ),
                    )),
              ),
              FadeAnimation(
                1.5,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.alarm,
                        size: 80,
                        color: blueClr,
                      ),
                    ),
                    Text(
                      '3:00',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: blackClr,
                          fontSize: 30,
                          fontFamily: 'Josefin',
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: Text(
                        'One Time Password  (OTP) has been sent to your registered mobile number. Please enter  One Time Password (OTP) within the stipulated time.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Baloo', fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        obscureText: true,
                        controller: txtPin,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 4,
                        decoration: InputDecoration(
                          hintText: '04 digit OTP',
                          // labelText: 'mobile number',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Verification Code';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 125, right: 125),
                      child: RaisedButton(
                        elevation: 10,
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10),
                        ),
                        color: greenClr,
                        splashColor: blackClr,
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Abel',
                          ),
                        ),
                        onPressed: () {
                          resendPin();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              FadeAnimation(
                2.0,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(0),
                      ),
                      splashColor: blackClr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(Icons.arrow_back, color: greenClr),
                          ),
                          Text(
                            "Back",
                            style: TextStyle(
                              color: greenClr,
                              fontSize: 20,
                              fontFamily: 'Abel',
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        navigateToRegister(context);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: blueClr)),
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: blueClr,
                              border: Border.all(color: blueClr)),
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              //color: blueClr,
                              border: Border.all(color: blueClr)),
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              //color: blueClr,
                              border: Border.all(color: blueClr)),
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              //color: blueClr,
                              border: Border.all(color: blueClr)),
                        )
                      ],
                    ),
                    FlatButton(
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(0),
                      ),
                      splashColor: blackClr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Next",
                            style: TextStyle(
                              color: greenClr,
                              fontSize: 20,
                              fontFamily: 'Abel',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(Icons.arrow_forward, color: greenClr),
                          )
                        ],
                      ),
                      onPressed: () {
                        checkPin();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigateToRegister(BuildContext context) {
    Routes.sailor.navigate('/register');
  }

  void navigateToSupplier(BuildContext context) {
    Routes.sailor.navigate(
      '/supplier',
      params: {
        'mobileNumber': mobileNumber,
        'pwd': pwd,
        'pin': _pin,
      },
    );
  }
}
