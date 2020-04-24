import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/main.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../Animation/FadeinAnimation.dart';

class PersonalInfo extends StatefulWidget {
  final String mobileNumber;
  final String pwd;
  final String usr;
  final int pin;

  PersonalInfo({
    @required this.mobileNumber,
    @required this.pwd,
    @required this.pin,
    @required this.usr,
  });

  @override
  _PersonalInfo createState() => _PersonalInfo(mobileNumber, pwd, pin, usr);
}

class _PersonalInfo extends State<PersonalInfo> {
  TextEditingController txtOwnerName = new TextEditingController();
  TextEditingController txtEmail = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String mobileNumber;
  String pwd;
  String usr;
  int pin;
  String businessName;
  String ownerName;
  String email;
  List tempList = [];

  ProgressDialog pr;

  _PersonalInfo(
    this.mobileNumber,
    this.pwd,
    this.pin,
    this.usr,
  );

  void registerPersonalInfo() async {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    try {
      final FormState form = _formKey.currentState;
      if (form.validate()) {
        print('Form is valid');
        bool emailValid = RegExp(
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(txtEmail.text);
        if (emailValid == false) {
          AlertDialog alert = AlertDialog(
            title: Text("Error!"),
            content: Text('Invalid Email'),
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
          // pr.show();
          businessName = '-';
          ownerName = txtOwnerName.text;
          email = txtEmail.text;
          // pr.hide();
          print(mobileNumber);
          print(pin);
          print(pwd);
          print(businessName);
          print(usr);
          print(ownerName);
          print(email);
          navigateToContactInfo(context);
        }
      } else {
        print('Form is invalid');
      }
    } catch (e) {
      // pr.hide();
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

  @override
  Widget build(BuildContext context) {
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
                  // color: blackClr,
                  child: Text(
                    'Registration',
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
                        Text('Personal Information',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: redClr,
                                fontSize: 25,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: TextFormField(
                            controller: txtOwnerName,
                            key: Key('customerName'),
                            textAlign: TextAlign.center,
                            //textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(40.0)),
                                    borderSide:
                                        new BorderSide(color: whiteClr)),
                                filled: true,
                                fillColor: whiteClr,
                                hintText: 'customer name',
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
                                //prefixIcon: Icon(Icons.phone_android),
                                // labelText: 'mobile number',
                                ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Customer Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: TextFormField(
                            controller: txtEmail,
                            key: Key('email'),
                            textAlign: TextAlign.center,
                            //textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(40.0)),
                                    borderSide:
                                        new BorderSide(color: whiteClr)),
                                filled: true,
                                fillColor: whiteClr,
                                hintText: 'email address',
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
                                //prefixIcon: Icon(Icons.phone_android),
                                // labelText: 'mobile number',
                                ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Enter Email Address';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
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
                      navigateToSupplier(context);
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
                          child: Icon(Icons.arrow_forward, color: blackClr),
                        )
                      ],
                    ),
                    onPressed: () {
                      registerPersonalInfo();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  void navigateToSupplier(BuildContext context) {
    Routes.sailor.navigate(
      '/supplier',
      params: {
        'mobileNumber': mobileNumber,
        'pwd': pwd,
        'pin': pin,
      },
    );
  }

  void navigateToContactInfo(BuildContext context) {
    Routes.sailor.navigate(
      '/contact',
      params: {
        'mobileNumber': mobileNumber,
        'pwd': pwd,
        'pin': pin,
        'businessName': businessName,
        'usr': usr,
        'ownerName': ownerName,
        'email': email,
        'natureList': tempList,
      },
    );
  }
}
