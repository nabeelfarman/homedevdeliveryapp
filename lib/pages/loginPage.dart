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
  int userID;
  String userName;
  int appTypeID;
  String email;
  int townID;

  TextEditingController mobile = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  ProgressDialog pr;

  bool validateMobile = false;
  bool validatePwd = false;

  Future<List> login() async {
    try {
      pr.show();
      String mobileNumber = mobile.text;
      String password = pwd.text;

      var response = await http.get(
          "http://95.217.147.105:2001/api/login?MobileNo=" +
              mobileNumber +
              "&HashPassword=" +
              password,
          headers: {
            "Content-Type": "application/json",
          });
      final Map responseJson = json.decode(response.body);

      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
          // navigateToHome(context);
        },
      );

      // print(responseJson["data"]["userID"]);
      if (responseJson["rows"].length != 0) {
        // showNotification();
        pr.hide();
        mobile.clear();
        pwd.clear();
        userID = responseJson["rows"][0]["userID"];
        userName = responseJson["rows"][0]["userName"];
        appTypeID = responseJson["rows"][0]["appTypeID"];
        email = responseJson["rows"][0]["email"];
        townID = responseJson["rows"][0]["townID"];

        // print(userID);
        // print(userName);
        // print(appTypeID);
        // print(email);

        navigateToSideBarLayout(context);
      } else {
        pr.hide();
        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Error!"),
          content: Text("Invalid Login Name & Password"),
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

    return MaterialApp(
        home: Scaffold(
      body: Container(
        // color: whiteClr,
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
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  'Welcome to Delivery',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: blackClr,
                    fontFamily: 'Anton',
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * (3 / 4),
                  // height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeAnimation(
                        1.5,
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, bottom: 30, right: 30, left: 30),
                          child: CircleAvatar(
                            child: Icon(
                              Icons.shopping_basket,
                              color: blackClr,
                              size: 40,
                            ),
                            radius: 50,
                            backgroundColor: whiteClr,
                          ),
                        ),
                      ),
                      FadeAnimation(
                        2.0,
                        TextField(
                          style: TextStyle(color: blackClr),
                          controller: mobile,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: new InputDecoration(
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0)),
                                  borderSide: new BorderSide(color: whiteClr)),
                              filled: true,
                              hintStyle: new TextStyle(
                                  color: blackClr.withOpacity(0.4)),
                              hintText: "mobile number",
                              prefixIcon: Icon(
                                Icons.phone_android,
                                color: blackClr.withOpacity(0.4),
                              ),
                              errorText: validateMobile
                                  ? 'Mobile Number is Required'
                                  : null,
                              errorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: redClr),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0))),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: blackClr),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0))),
                              fillColor: whiteClr,
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: blackClr),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0)))),
                        ),
                      ),
                      FadeAnimation(
                        2.0,
                        TextField(
                          style: TextStyle(color: blackClr),
                          controller: pwd,
                          maxLength: 15,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          decoration: new InputDecoration(
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0)),
                                  borderSide: new BorderSide(color: whiteClr)),
                              filled: true,
                              hintStyle: new TextStyle(
                                  color: blackClr.withOpacity(0.4)),
                              hintText: "password",
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: blackClr.withOpacity(0.4),
                              ),
                              errorText:
                                  validatePwd ? 'Password is Required' : null,
                              errorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: redClr),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0))),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: blackClr),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0))),
                              fillColor: whiteClr,
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: blackClr),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0)))),
                        ),
                      ),
                      FadeAnimation(
                          2.5,
                          RaisedButton(
                            elevation: 5,
                            padding: EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 5.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            color: redClr,
                            splashColor: greyClr,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Baloo',
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
                    ],
                  ),
                )
              ],
            ),
            Row(
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
                              color: whiteClr,
                              fontSize: 16,
                              fontFamily: 'Baloo')),
                      GestureDetector(
                          child: Text(" Register",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: blackClr,
                                  fontSize: 16,
                                  fontFamily: 'Josefin')),
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
                            color: redClr,
                            fontSize: 16,
                            fontFamily: 'Baloo')),
                    onTap: () {
                      navigateToForgot(context);
                    }),
              ],
            ),
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

  void navigateToSideBarLayout(BuildContext context) {
    Routes.sailor.navigate(
      '/sideBarLayout',
      params: {
        'userID': userID,
        'userName': userName,
        'appTypeID': appTypeID,
        'email': email,
        'townID': townID,
      },
    );
  }
}
