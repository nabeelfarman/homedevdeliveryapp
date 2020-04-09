import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:http/http.dart' as http;
import 'package:homemobileapp/main.dart';

class ContactInfo extends StatefulWidget {
  final String mobileNumber;
  final String pwd;
  final String usr;
  final String businessName;
  final String ownerName;
  final String email;
  final int pin;

  ContactInfo({
    @required this.mobileNumber,
    @required this.pwd,
    @required this.pin,
    @required this.usr,
    this.businessName,
    @required this.ownerName,
    @required this.email,
  });
  @override
  _ContactInfo createState() => _ContactInfo(
        mobileNumber,
        pwd,
        pin,
        usr,
        businessName,
        ownerName,
        email,
      );
}

class _ContactInfo extends State<ContactInfo> {
  String mobileNumber;
  String pwd;
  String usr;
  String businessName;
  String ownerName;
  String email;
  int pin;

  _ContactInfo(
    this.mobileNumber,
    this.pwd,
    this.pin,
    this.usr,
    this.businessName,
    this.ownerName,
    this.email,
  );

  //declarations
  Color blackClr = Color(0xff141622);
  Color greenClr = Color(0xff8cc540);
  Color blueClr = Color(0xff408cc5);
  Color bodyClr = Color(0xfff8f7f7);

//dropDowns
  List province_data = List();
  List district_data = List();

  String _province;
  String _district;

  //dropdown lists
  // List<DropdownMenuItem<int>> listProvince = [];
  void initState() {
    super.initState();
    this.getDistrict();
    this.getProvince();
  }

  Future<String> getProvince() async {
    try {
      var response = await http.get(
          Uri.encodeFull(
            "http://ambit.southeastasia.cloudapp.azure.com:9026/api/getProvince",
          ),
          headers: {"Accept": "application/json"});
      // final String responseJson = response.body;
      var resBody = json.decode(response.body);
      setState(() {
        province_data = resBody;
      });
      return "Success";
    } catch (e) {
      print(e);
      // Widget okButton = FlatButton(
      //   child: Text("OK"),
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      // );
      // AlertDialog alert = AlertDialog(
      //   title: Text("Error!"),
      //   content: Text(e.toString()),
      //   actions: [
      //     okButton,
      //   ],
      // );
      // // show the dialog
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return alert;
      //   },
      // );
    }
  }

  Future<String> getDistrict() async {
    try {
      var response = await http.get(
          Uri.encodeFull(
            "http://ambit.southeastasia.cloudapp.azure.com:9026/api/getDistrict",
          ),
          headers: {"Accept": "application/json"});
      // final String responseJson = response.body;
      var resBody = json.decode(response.body);
      setState(() {
        district_data = resBody;
      });
      return "Success";
    } catch (e) {
      print(e);
      // Widget okButton = FlatButton(
      //   child: Text("OK"),
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      // );
      // AlertDialog alert = AlertDialog(
      //   title: Text("Error!"),
      //   content: Text(e.toString()),
      //   actions: [
      //     okButton,
      //   ],
      // );
      // // show the dialog
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return alert;
      //   },
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    'Registration',
                    style: TextStyle(
                        color: greenClr, fontSize: 40, fontFamily: 'Abel'),
                  ),
                )),
          ),
          FadeAnimation(
            1.5,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Contact Information',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: blueClr,
                        fontSize: 30,
                        fontFamily: 'Abel',
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
                  child: DropdownButton(
                    isExpanded: true,
                    items: province_data.map((item) {
                      return DropdownMenuItem(
                        value: item['prvncCd'].toString(),
                        child: new Text(item['prvinceName']),
                      );
                    }).toList(),
                    hint: new Text('select province'),
                    onChanged: (newVal) {
                      setState(() {
                        _province = newVal;
                      });
                    },
                    value: _province,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                  child: DropdownButton(
                    isExpanded: true,
                    items: district_data.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['districtName']),
                        value: item['districtCd'].toString(),
                      );
                    }).toList(),
                    onChanged: (newVal) {
                      setState(() {
                        _district = newVal;
                      });
                    },
                    value: _district,
                    hint: new Text('select district'),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: DropdownButton(
                        isExpanded: true,
                        items: null,
                        hint: new Text('select city'),
                        onChanged: null)),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: DropdownButton(
                        isExpanded: true,
                        items: null,
                        hint: new Text('select tehsil'),
                        onChanged: null)),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: DropdownButton(
                        isExpanded: true,
                        items: null,
                        hint: new Text('select town'),
                        onChanged: null)),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          hintMaxLines: 4, hintText: 'contact address'),
                    )),
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
                    // navigateToBusiness(context);
                    getDistrict();
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
                            color: blueClr,
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
                    print(_district);
                    print(_province);
                  },
                )
              ],
            ),
          )
        ],
      ),
    ));
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
}
