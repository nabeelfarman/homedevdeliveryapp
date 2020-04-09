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
    try {
      _regPwd = regPwd.text;
      _cnfrmPwd = cnfrmPwd.text;

      if (_regPwd != _cnfrmPwd) {
        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
            // navigateToHome(context);
          },
        );
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
          'http://95.217.147.105:2003/api/genotp',
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: jsonEncode(<String, String>{'Cellno': _mobile, 'Code': _code}),
        );

        final Map responseJson = json.decode(response.body);
        print(responseJson['msg']);
        _pin = responseJson['msg'];
        pr.hide();
        navigateToVerification(context);
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
        body: Container(
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
                              color: greenClr,
                              fontSize: 40,
                              fontFamily: 'Abel'),
                        ),
                      )),
                ),
                FadeAnimation(
                    1.5,
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: Container(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('REGISTER YOUR MOBILE',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: blueClr,
                                      fontSize: 30,
                                      fontFamily: 'Abel',
                                      fontWeight: FontWeight.bold)),
                              TextFormField(
                                controller: regMobile,
                                key: Key('mobileNumber'),
                                keyboardType: TextInputType.number,
                                //textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: 'mobile number',
                                  prefixIcon: Icon(Icons.phone_android),
                                  errorText: validateRegMobile
                                      ? 'Mobile is Required'
                                      : null,
                                  // labelText: 'mobile number',
                                ),
                              ),
                              TextFormField(
                                controller: regPwd,
                                key: Key('password'),
                                obscureText: true,
                                //textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: 'password',
                                  prefixIcon: Icon(Icons.lock_outline),
                                  errorText: validateRegPwd
                                      ? 'Password is Required'
                                      : null,
                                  // labelText: 'mobile number',
                                ),
                              ),
                              TextFormField(
                                controller: cnfrmPwd,
                                key: Key('confirmPassword'),
                                obscureText: true,
                                //textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: 'confirm password',
                                  prefixIcon: Icon(Icons.done),
                                  errorText: validateCnfrmPwd
                                      ? 'Confirm Password is Required'
                                      : null,
                                  // labelText: 'mobile number',
                                ),
                              ),
                            ],
                          )),
                    )),
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
                                  color: blueClr,
                                  shape: BoxShape.circle,
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
                )
              ],
            )));
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
