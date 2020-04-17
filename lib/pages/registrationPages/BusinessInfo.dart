import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/main.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../Animation/FadeinAnimation.dart';

class BusinessInfo extends StatefulWidget {
  final String mobileNumber;
  final String pwd;
  final String usr;
  final int pin;

  BusinessInfo({
    @required this.mobileNumber,
    @required this.pwd,
    @required this.pin,
    @required this.usr,
  });

  @override
  _BusinessInfo createState() => _BusinessInfo(
        mobileNumber,
        pwd,
        pin,
        usr,
      );
}

class _BusinessInfo extends State<BusinessInfo> {
  Color blackClr = Color(0xff2d2d2d);
  // Color yellowClr = Color(0xfff7d73a);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0fffdebe7);
  Color purpleClr = Color(0x0ffd183fd);
  Color greenClr = Color(0x0ff8ee269);
  Color redClr = Color(0x0fff0513c);

  TextEditingController txtBusinessName = new TextEditingController();
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

  ProgressDialog pr;

  List categories = [
    {'categoryID': '1', 'categoryTitle': 'Groccery', 'checked': 'false'},
    {'categoryID': '2', 'categoryTitle': 'Vegetable', 'checked': 'false'},
    {'categoryID': '3', 'categoryTitle': 'Fruits', 'checked': 'false'},
    {'categoryID': '4', 'categoryTitle': 'Meat', 'checked': 'false'}
  ];

  _BusinessInfo(
    this.mobileNumber,
    this.pwd,
    this.pin,
    this.usr,
  );

  void registerBusinessInfo() async {
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
          businessName = txtBusinessName.text;
          ownerName = txtOwnerName.text;
          email = txtEmail.text;
          // pr.hide();
          print(mobileNumber);
          print(pin);
          print(pwd);
          print(businessName);
          print(ownerName);
          print(email);
          print(usr);
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
        // color: whiteClr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Material(
              elevation: 2,
              child: FadeAnimation(
                  1.0,
                  Container(
                    height: 80,
                    alignment: Alignment.bottomCenter,
                    color: whiteClr,
                    child: Text(
                      'Registration',
                      style: TextStyle(
                          color: redClr, fontSize: 40, fontFamily: 'Josefin'),
                    ),
                  )),
            ),
            FadeAnimation(
              1.5,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Business Information',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: greenClr,
                          fontSize: 30,
                          fontFamily: 'Baloo',
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: TextFormField(
                      controller: txtBusinessName,
                      key: Key('businessName'),
                      textAlign: TextAlign.center,
                      //textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'business name',
                        //prefixIcon: Icon(Icons.phone_android),
                        // labelText: 'mobile number',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Business Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: TextFormField(
                      controller: txtOwnerName,
                      key: Key('ownerName'),
                      textAlign: TextAlign.center,
                      //textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'owner name',
                        //prefixIcon: Icon(Icons.phone_android),
                        // labelText: 'mobile number',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Owner Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: TextFormField(
                      controller: txtEmail,
                      key: Key('email'),
                      textAlign: TextAlign.center,
                      //textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'email address',
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
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: new ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = categories[index];
                          return new Card(
                            child: new Container(
                              padding: new EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  new CheckboxListTile(
                                      value: item['checked'] == 'true'
                                          ? true
                                          : false,
                                      onChanged: (bool value) {
                                        setState(() {
                                          item['checked'] = value.toString();
                                          print(item['checked'] +
                                              ' ' +
                                              item['categoryTitle']);
                                        });
                                      },
                                      title: new Text(item['categoryTitle']))
                                ],
                              ),
                            ),
                          );
                        }),
                  )
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
                      registerBusinessInfo();
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
      },
    );
  }
}
