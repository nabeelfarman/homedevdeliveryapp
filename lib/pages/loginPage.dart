import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';
import '../Animation/FadeinAnimation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with SingleTickerProviderStateMixin {
  // AnimationController _controller;

  TextEditingController mobile = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  ProgressDialog pr;

  bool validateMobile = false;
  bool validatePwd = false;

  Future<List> login() async {
    try {
      pr.show();

      http.Response response = await http.get(
          Uri.encodeFull("http://95.217.147.105:2002/api/login?UserName=" +
              mobile.text +
              "&HashPassword=" +
              pwd.text),
          headers: {"Accept": "application/json"});
      final Map responseJson = json.decode(response.body);

      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
          // navigateToHome(context);
        },
      );
      if (responseJson["msg"] == "User successfully logged in") {
        // showNotification();
        pr.hide();
        mobile.clear();
        pwd.clear();
        AlertDialog alert = AlertDialog(
          title: Text("Success!"),
          content: Text(responseJson["msg"]),
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
        pr.hide();
        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Error!"),
          content: Text(responseJson["msg"]),
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

    return MaterialApp(
        home: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: bodyClr,
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.bottomCenter,
                widthFactor: 0.5,
                heightFactor: 0.6,
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  color: blackClr,
                  child: FadeAnimation(
                      1.0,
                      Container(
                        width: 400,
                        height: 400,
                      )),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 85),
              child: FadeAnimation(
                  1.0,
                  Text('LOGIN',
                      style: TextStyle(
                          color: bodyClr, fontSize: 40, fontFamily: 'Abel'))),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: FadeAnimation(
                      1.5,
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Icon(
                          Icons.shopping_basket,
                          color: blueClr,
                          size: 70,
                        ),
                      )),
                ),
                Center(
                  child: FadeAnimation(
                    2.0,
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Material(
                        elevation: 5,
                        child: Container(
                          width: 300,
                          height: 170,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: TextFormField(
                                  controller: mobile,
                                  maxLength: 11,
                                  keyboardType: TextInputType.number,
                                  key: Key('mobileNumber'),
                                  decoration: InputDecoration(
                                    hintText: '03001234567',
                                    // labelText: 'mobile number',
                                    prefixIcon: Icon(Icons.phone_android),
                                    errorText: validateMobile
                                        ? 'Mobile Number is Required'
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 10),
                                child: TextFormField(
                                  controller: pwd,
                                  key: Key('password'),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'password',
                                    // labelText: 'mobile number',
                                    prefixIcon: Icon(Icons.lock_outline),
                                    errorText: validatePwd
                                        ? 'Password is Required'
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: FadeAnimation(
                        2.5,
                        RaisedButton(
                          elevation: 5,
                          padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          color: Color(0xff8cc540),
                          splashColor: Color(0xff141622),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Abel',
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              mobile.text.isEmpty
                                  ? validateMobile = true
                                  : validateMobile = false;
                              pwd.text.isEmpty
                                  ? validatePwd = true
                                  : validatePwd = false;
                              if (mobile.text.isNotEmpty &&
                                  pwd.text.isNotEmpty) {
                                login();
                              }
                            });
                          },
                        )),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: 300,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text('If New?',
                                style: TextStyle(
                                    color: blackClr,
                                    fontSize: 16,
                                    fontFamily: 'Baloo')),
                            GestureDetector(
                                child: Text("Register",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: greenClr,
                                        fontSize: 18,
                                        fontFamily: 'Abel')),
                                onTap: () {
                                  navigateToRegister(context);
                                }),
                          ],
                        ),
                      ),
                      GestureDetector(
                          child: Text("forget password",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: blueClr,
                                  fontSize: 18,
                                  fontFamily: 'Abel')),
                          onTap: () {
                            navigateToForgot(context);
                          }),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  void navigateToRegister(BuildContext context) {
    Routes.sailor.navigate('/register');
  }

  void navigateToForgot(BuildContext context) {
    Routes.sailor.navigate('/verification');
  }
}
