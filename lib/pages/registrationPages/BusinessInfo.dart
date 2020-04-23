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
  //declarations
  Color blackClr = Color(0xff1D2028);
  Color pinkClr = Color(0xffFF9C81);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0ffEEF2F5);
  Color greyClr = Color(0x0ffB5BED0);
  Color greenClr = Color(0x0ff3CB54B);
  Color redClr = Color(0x0ffE72C2D);
  Color blueClr = Color(0x0ff0858D3);

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

  List tempList = [];
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
          if (tempList.length == 0) {
            AlertDialog alert = AlertDialog(
              title: Text("Error!"),
              content: Text('Business Nature is Required'),
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
            print(tempList);
            navigateToContactInfo(context);
          }
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
      appBar: new AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: pinkClr,
          title: Text('Business Information',
              style: TextStyle(
                  color: whiteClr, fontFamily: 'Anton', fontSize: 25))),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // color: whiteClr,
          child: Container(
            color: lightClr,
            width: MediaQuery.of(context).size.width,
            constraints: new BoxConstraints(
                minHeight: MediaQuery.of(context).size.height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * (3 / 4),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        1.5,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: TextFormField(
                                controller: txtBusinessName,
                                key: Key('businessName'),
                                textAlign: TextAlign.center,
                                //textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    enabledBorder: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(40.0)),
                                        borderSide:
                                            new BorderSide(color: greyClr)),
                                    filled: true,
                                    fillColor: lightClr,
                                    hintText: 'business name',
                                    errorBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: redClr),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(40.0))),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: pinkClr),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(40.0))),
                                    focusedBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: pinkClr),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(40.0)))
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
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: TextFormField(
                                controller: txtOwnerName,
                                key: Key('ownerName'),
                                textAlign: TextAlign.center,
                                //textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    enabledBorder: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(40.0)),
                                        borderSide:
                                            new BorderSide(color: greyClr)),
                                    filled: true,
                                    fillColor: lightClr,
                                    hintText: 'owner name',
                                    errorBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: redClr),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(40.0))),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: pinkClr),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(40.0))),
                                    focusedBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: pinkClr),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(40.0)))
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
                              padding: const EdgeInsets.only(
                                top: 20,
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
                                            new BorderSide(color: greyClr)),
                                    filled: true,
                                    fillColor: lightClr,
                                    hintText: 'email address',
                                    errorBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: redClr),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(40.0))),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: pinkClr),
                                        borderRadius: const BorderRadius.all(
                                            const Radius.circular(40.0))),
                                    focusedBorder: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: pinkClr),
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
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: new ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: categories.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final item = categories[index];
                                    return new Card(
                                      color: whiteClr,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
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
                                                    item['checked'] =
                                                        value.toString();
                                                    print(item['checked'] +
                                                        ' ' +
                                                        item['categoryTitle']);
                                                  });
                                                },
                                                title: new Text(
                                                    item['categoryTitle']))
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: whiteClr,
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
                    child: Icon(Icons.arrow_back, color: pinkClr),
                  ),
                  Text(
                    "Back",
                    style: TextStyle(
                      color: pinkClr,
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
                        border: Border.all(color: greyClr)),
                  ),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //color: blueClr,
                        border: Border.all(color: greyClr)),
                  ),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //color: blueClr,
                        border: Border.all(color: greyClr)),
                  ),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: greyClr,
                        border: Border.all(color: greyClr)),
                  ),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //color: blueClr,
                        border: Border.all(color: greyClr)),
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
                      color: pinkClr,
                      fontSize: 20,
                      fontFamily: 'Abel',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(Icons.arrow_forward, color: pinkClr),
                  )
                ],
              ),
              onPressed: () {
                registerBusinessInfo();
              },
            )
          ],
        ),
      ),
    );
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
