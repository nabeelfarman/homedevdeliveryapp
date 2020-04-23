import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';

class UserNamePassword extends StatefulWidget {
  @override
  _UserNamePassword createState() => _UserNamePassword();
}

class _UserNamePassword extends State<UserNamePassword>
    with SingleTickerProviderStateMixin {
  TextEditingController regMobile = new TextEditingController();
  TextEditingController regPwd = new TextEditingController();
  TextEditingController cnfrmPwd = new TextEditingController();

  ProgressDialog pr;

  bool validateRegMobile = false;
  bool validateRegPwd = false;
  bool validateCnfrmPwd = false;

  String _mobile;
  String _regPwd;
  String _cnfrmPwd;
  String _code;
  int _pin;

  Future<String> genPin() async {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        // navigateToHome(context);
      },
    );
    try {
      _regPwd = regPwd.text;
      _cnfrmPwd = cnfrmPwd.text;

      if (_regPwd != _cnfrmPwd) {
        AlertDialog alert = AlertDialog(
          title: Text("Success!"),
          content: Text('Password & Confirm Password not Matched'),
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
      } else {
        _mobile = regMobile.text;
        _code = "123";

        pr.show();

        http.Response response = await http.post(
          'http://95.217.147.105:2001/api/genotp',
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: jsonEncode(<String, String>{'Cellno': _mobile, 'Code': _code}),
        );

        final Map responseJson = json.decode(response.body);
        pr.hide();

        print(responseJson['msg']);
        if (responseJson['msg'] == 'Mobile Number Already Exist!') {
          AlertDialog alert = AlertDialog(
            title: Text("Success!"),
            content: Text(responseJson['msg']),
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
        } else {
          _pin = responseJson['msg'];
          navigateToVerification(context);
        }
      }
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

  @override
  Widget build(BuildContext context) {
    //declarations
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Container(
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
                        // color: darkYellowClr,
                        child: Text(
                          'REGISTRATION',
                          style: TextStyle(
                              color: blackClr,
                              fontSize: 30,
                              fontFamily: 'Anton'),
                        ),
                      )),
                  FadeAnimation(
                      1.5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * (3 / 4),
                            child: Container(
                                // height: 250,
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Text('Your Credentials',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: redClr,
                                          fontSize: 25,
                                          fontFamily: 'Ubuntu',
                                          fontWeight: FontWeight.bold)),
                                ),
                                TextField(
                                  controller: regMobile,
                                  maxLength: 10,
                                  key: Key('mobileNumber'),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      enabledBorder: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(40.0)),
                                          borderSide:
                                              new BorderSide(color: whiteClr)),
                                      filled: true,
                                      fillColor: whiteClr,
                                      hintText: 'moblie number',
                                      prefixIcon: Icon(
                                        Icons.phone_android,
                                        color: Colors.grey,
                                      ),
                                      errorText: validateRegMobile
                                          ? 'Mobile is Required'
                                          : null,
                                      errorBorder: new OutlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: redClr),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(40.0))),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: blackClr),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(40.0))),
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: blackClr),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(40.0)))),
                                ),
                                TextField(
                                  controller: regPwd,
                                  key: Key('password'),
                                  obscureText: true,
                                  maxLength: 15,
                                  //textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      enabledBorder: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(40.0)),
                                          borderSide:
                                              new BorderSide(color: whiteClr)),
                                      filled: true,
                                      fillColor: whiteClr,
                                      hintText: 'password',
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: Colors.grey,
                                      ),
                                      errorText: validateRegPwd
                                          ? 'Password is Required'
                                          : null,
                                      errorBorder: new OutlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: redClr),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(40.0))),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: blackClr),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(40.0))),
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: blackClr),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(40.0)))
                                      // labelText: 'mobile number',
                                      ),
                                ),
                                TextField(
                                  controller: cnfrmPwd,
                                  key: Key('confirmPassword'),
                                  obscureText: true,
                                  //textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      enabledBorder: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(40.0)),
                                          borderSide:
                                              new BorderSide(color: whiteClr)),
                                      filled: true,
                                      hintText: 'confirm password',
                                      prefixIcon: Icon(Icons.done),
                                      errorText: validateCnfrmPwd
                                          ? 'Confirm Password is Required'
                                          : null,
                                      errorBorder: new OutlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: redClr),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(40.0))),
                                      focusedErrorBorder: new OutlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: blackClr),
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(40.0))),
                                      fillColor: whiteClr,
                                      focusedBorder: new OutlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: blackClr),
                                          borderRadius: const BorderRadius.all(const Radius.circular(40.0)))
                                      // labelText: 'mobile number',
                                      ),
                                ),
                              ],
                            )),
                          ),
                        ],
                      )),
                  FadeAnimation(
                    2.0,
                    Container(
                      // color: whiteClr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            padding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(0),
                            ),
                            splashColor: greyClr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child:
                                      Icon(Icons.arrow_back, color: blackClr),
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
                              navigateToLogin(context);
                            },
                          ),
                          Container(
                            width: 100,
                            height: 30,
                            //color: Colors.orangeAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: redClr,
                                      shape: BoxShape.circle,
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
                          ),
                          FlatButton(
                            padding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(0),
                            ),
                            splashColor: greyClr,
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
                                  child: Icon(Icons.arrow_forward,
                                      color: blackClr),
                                )
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                regMobile.text.isEmpty
                                    ? validateRegMobile = true
                                    : validateRegMobile = false;
                                regPwd.text.isEmpty
                                    ? validateRegPwd = true
                                    : validateRegPwd = false;
                                cnfrmPwd.text.isEmpty
                                    ? validateCnfrmPwd = true
                                    : validateCnfrmPwd = false;

                                if (regMobile.text.isNotEmpty &&
                                    regPwd.text.isNotEmpty &&
                                    cnfrmPwd.text.isNotEmpty) {
                                  genPin();
                                }
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }

  void navigateToLogin(BuildContext context) {
    Routes.sailor.navigate('/login');
  }

  void navigateToVerification(BuildContext context) {
    Routes.sailor.navigate(
      '/verification',
      params: {
        'mobileNumber': _mobile,
        'pwd': _regPwd,
        'pin': _pin,
      },
    );
  }
}
