import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:homemobileapp/main.dart';

class SupplierCustomer extends StatefulWidget {
  final String mobileNumber;
  final String pwd;
  final int pin;
  SupplierCustomer({
    this.mobileNumber,
    this.pwd,
    this.pin,
  });

  @override
  _SupplierCustomer createState() => _SupplierCustomer(mobileNumber, pwd, pin);
}

class _SupplierCustomer extends State<SupplierCustomer> {
  String mobileNumber;
  String pwd;
  int pin;
  String usr;

  int selectedRadio = 0;

  _SupplierCustomer(
    this.mobileNumber,
    this.pwd,
    this.pin,
  );

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void registerUser() async {
    try {
      if (selectedRadio == 0) {
        usr = '2';
        print(usr);
        navigateToBusiness(context);
      } else if (selectedRadio == 1) {
        usr = '1';
        print(usr);
        navigateToPersonal(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //declaration
    Color blackClr = Color(0xff1D2028);

    Color whiteClr = Color(0x0ffffffff);
    Color lightClr = Color(0x0ffEEF2F5);
    Color greyClr = Color(0x0ffB5BED0);
    Color greenClr = Color(0x0ffA3C12E);
    Color redClr = Color(0x0ffcf3f3d);

    Color yellowClr = Color(0x0ffF8D247);
    Color darkYellowClr = Color(0x0ffdfbd3f);
    Color lightYellowClr = Color(0x0ffffde22);

    return Scaffold(
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
                      // color: pinkClr,
                      child: Text(
                        'REGISTRATION',
                        style: TextStyle(
                            color: blackClr, fontSize: 30, fontFamily: 'Anton'),
                      ),
                    )),
                FadeAnimation(
                  1.5,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Want to Become',
                            style: TextStyle(
                                color: redClr,
                                fontSize: 25,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                                value: 0,
                                groupValue: selectedRadio,
                                activeColor: blackClr,
                                onChanged: (val) {
                                  print('Radio $val');
                                  setSelectedRadio(val);
                                }),
                            Text(
                              'Supplier',
                              style: TextStyle(
                                color: blackClr,
                                fontSize: 18,
                                fontFamily: 'Josefin',
                              ),
                            ),
                            Radio(
                                value: 1,
                                groupValue: selectedRadio,
                                activeColor: blackClr,
                                onChanged: (val) {
                                  print('Radio $val');
                                  setSelectedRadio(val);
                                }),
                            Text('Customer',
                                style: TextStyle(
                                    color: blackClr,
                                    fontSize: 18,
                                    fontFamily: 'Josefin'))
                          ],
                        ),
                      )
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
                            navigateToVerification(context);
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
                                    //color: blueClr,
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
                              )
                            ],
                          ),
                        ),
                        FlatButton(
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                                child:
                                    Icon(Icons.arrow_forward, color: blackClr),
                              )
                            ],
                          ),
                          onPressed: () {
                            print(mobileNumber);
                            print(pwd);
                            print(pin);
                            registerUser();
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  void navigateToVerification(BuildContext context) {
    if (pin == null) {
      pin = 1234;
    } else {
      Routes.sailor.navigate(
        '/verification',
        params: {
          'mobileNumber': mobileNumber,
          'pwd': pwd,
          'pin': pin,
        },
      );
    }
  }

  void navigateToBusiness(BuildContext context) {
    Routes.sailor.navigate(
      '/business',
      params: {
        'mobileNumber': mobileNumber,
        'pwd': pwd,
        'pin': pin,
        'usr': usr,
      },
    );
  }

  void navigateToPersonal(BuildContext context) {
    Routes.sailor.navigate(
      '/personal',
      params: {
        'mobileNumber': mobileNumber,
        'pwd': pwd,
        'pin': pin,
        'usr': usr,
      },
    );
  }
}
