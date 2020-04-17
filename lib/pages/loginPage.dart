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

      print(responseJson["msg"]);
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
    Color blackClr = Color(0xff2d2d2d);
    // Color yellowClr = Color(0xfff7d73a);
    Color whiteClr = Color(0x0ffffffff);
    Color lightClr = Color(0x0fffdebe7);
    Color purpleClr = Color(0x0ffd183fd);
    Color greenClr = Color(0x0ff8ee269);
    Color redClr = Color(0x0fff0513c);

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
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: redClr,
        title: Text(
          'Welcome to Delivery',
          style: TextStyle(color: whiteClr, fontFamily: 'Lato', fontSize: 25),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: redClr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FadeAnimation(
                1.5,
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, bottom: 30, right: 30, left: 30),
                  child: CircleAvatar(
                    child: Icon(
                      Icons.shopping_basket,
                      color: redClr,
                      size: 40,
                    ),
                    radius: 50,
                    backgroundColor: whiteClr,
                  ),
                )),
            Center(
              child: FadeAnimation(
                2.0,
                Container(
                  width: 350,
                  // color: whiteClr,
                  decoration: BoxDecoration(
                    color: whiteClr,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)),
                    boxShadow: [
                      new BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: new Offset(10.0, 10.0),
                          blurRadius: 20.0)
                    ],
                  ),
                  // height: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 20, left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: TextFormField(
                            controller: mobile,
                            maxLength: 11,
                            keyboardType: TextInputType.number,
                            key: Key('mobileNumber'),
                            style: TextStyle(color: whiteClr),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: blackClr,
                                  fontFamily: 'Baloo',
                                  fontSize: 18),
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
                              errorText:
                                  validatePwd ? 'Password is Required' : null,
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          padding: const EdgeInsets.only(top: 20),
                          child: FadeAnimation(
                              2.5,
                              RaisedButton(
                                elevation: 5,
                                padding:
                                    EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 5.0),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10),
                                ),
                                color: redClr,
                                splashColor: greenClr,
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: 300,
        height: 50,
        color: redClr,
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
                          color: blackClr, fontSize: 16, fontFamily: 'Baloo')),
                  GestureDetector(
                      child: Text(" Register",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: whiteClr,
                              fontSize: 18,
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
                        color: whiteClr,
                        fontSize: 18,
                        fontFamily: 'Baloo')),
                onTap: () {
                  navigateToForgot(context);
                }),
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
