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
  bool validateOTP = false;

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
    Color blackClr = Color(0xff1D2028);

    Color whiteClr = Color(0x0ffffffff);
    Color lightClr = Color(0x0ffEEF2F5);
    Color greyClr = Color(0x0ffB5BED0);
    Color greenClr = Color(0x0ffA3C12E);
    Color redClr = Color(0x0ffcf3f3d);

    Color yellowClr = Color(0x0ffF8D247);
    Color darkYellowClr = Color(0x0ffdfbd3f);
    Color lightYellowClr = Color(0x0ffffde22);

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
          decoration: new BoxDecoration(
            // color: yellowClr,
            gradient: new LinearGradient(
                colors: [darkYellowClr, lightYellowClr, yellowClr],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FadeAnimation(
                  1.0,
                  Container(
                    height: 80,
                    alignment: Alignment.bottomCenter,
                    // color: pinkClr,
                    child: Text(
                      'REGISTRATION',
                      style: TextStyle(
                          color: blackClr, fontSize: 30, fontFamily: 'Anton'),
                    ),
                  )),
              FadeAnimation(
                1.5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * (3 / 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Center(
                            child: Icon(
                              Icons.alarm,
                              size: 80,
                              color: greyClr,
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
                          Text(
                            'One Time Password  (OTP) has been sent to your registered mobile number. Please enter  One Time Password (OTP) within the stipulated time.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Baloo', fontSize: 18),
                          ),
                          TextField(
                            obscureText: true,
                            controller: txtPin,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 4,
                            decoration: InputDecoration(
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(40.0)),
                                    borderSide:
                                        new BorderSide(color: whiteClr)),
                                filled: true,
                                fillColor: whiteClr,
                                hintText: '04 digit OTP',
                                errorText: validateOTP
                                    ? 'Enter Verification Code'
                                    : null,
                                errorBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: redClr),
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(40.0))),
                                focusedErrorBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: blackClr),
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(40.0))),
                                focusedBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(color: blackClr),
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(40.0)))
                                // labelText: 'mobile number',
                                ),
                          ),
                          RaisedButton(
                            elevation: 5,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            color: redClr,
                            splashColor: greyClr,
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                color: whiteClr,
                                fontSize: 16,
                                fontFamily: 'Abel',
                              ),
                            ),
                            onPressed: () {
                              resendPin();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FadeAnimation(
                2.0,
                Container(
                  // color: whiteClr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0),
                        ),
                        splashColor: greyClr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.arrow_back, color: blackClr),
                            ),
                            Text(
                              "Back",
                              style: TextStyle(
                                color: blackClr,
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
                                border: Border.all(color: redClr)),
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: redClr,
                                border: Border.all(color: redClr)),
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //color: blueClr,
                                border: Border.all(color: redClr)),
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //color: blueClr,
                                border: Border.all(color: redClr)),
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //color: blueClr,
                                border: Border.all(color: redClr)),
                          )
                        ],
                      ),
                      FlatButton(
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(0),
                        ),
                        splashColor: redClr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Next",
                              style: TextStyle(
                                color: blackClr,
                                fontSize: 20,
                                fontFamily: 'Abel',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(Icons.arrow_forward, color: blackClr),
                            )
                          ],
                        ),
                        onPressed: () {
                          checkPin();
                        },
                      )
                    ],
                  ),
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
