import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:http/http.dart' as http;
import 'package:homemobileapp/main.dart';
import 'package:progress_dialog/progress_dialog.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController txtAddress = new TextEditingController();

  ProgressDialog pr;

  _ContactInfo(
    this.mobileNumber,
    this.pwd,
    this.pin,
    this.usr,
    this.businessName,
    this.ownerName,
    this.email,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//dropDowns
  List province_data = List();
  List district_data = List();
  List tehsil_data = List();
  List town_data = List();

  String _province;
  String _district;
  String _tehsil;
  String _town;

  int userID;
  String userName;
  int appTypeID;
  String uEmail;
  int townID;

  //dropdown lists
  // List<DropdownMenuItem<int>> listProvince = [];
  void initState() {
    super.initState();
    this.getProvince();
  }

  Future<String> getProvince() async {
    try {
      var response = await http.get(
          Uri.encodeFull(
            "http://95.217.147.105:2001/api/getprovince",
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

  Future<String> getDistrict(String provinceID) async {
    try {
      pr.show();
      var response = await http.get(
          Uri.encodeFull(
            "http://95.217.147.105:2001/api/getdistrict?ProvinceID=" +
                provinceID,
          ),
          headers: {"Accept": "application/json"});
      // final String responseJson = response.body;
      var resBody = json.decode(response.body);
      setState(() {
        district_data = resBody;
      });
      pr.hide();
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

  Future<String> getTehsil(String districtID) async {
    try {
      pr.show();
      var response = await http.get(
          Uri.encodeFull(
            "http://95.217.147.105:2001/api/gettehsil?DistrictID=" + districtID,
          ),
          headers: {"Accept": "application/json"});
      // final String responseJson = response.body;
      var resBody = json.decode(response.body);
      setState(() {
        tehsil_data = resBody;
      });
      pr.hide();
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

  Future<String> getTown(String tehsilID) async {
    try {
      pr.show();
      var response = await http.get(
          Uri.encodeFull(
            "http://95.217.147.105:2001/api/gettown?TehsilID=" + tehsilID,
          ),
          headers: {"Accept": "application/json"});
      // final String responseJson = response.body;
      var resBody = json.decode(response.body);
      setState(() {
        town_data = resBody;
      });
      pr.hide();
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

  void registerContact() async {
    final FormState form = _formKey.currentState;
    try {
      if (!form.validate()) {
        showMessage('Form is not valid!  Please review and correct.');
      } else {
        pr.show();
        http.Response response = await http.post(
          'http://95.217.147.105:2001/api/reguser',
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: jsonEncode(
            {
              "UserName": ownerName,
              "HashPassword": pwd,
              "CompanyName": businessName,
              "AppTypeID": int.parse(usr),
              "PhoneNo": 0,
              "CellNo": int.parse(mobileNumber),
              "Email": email,
              "TownID": int.parse(_town),
              "Address": txtAddress.text,
              "Nearby": '-',
            },
          ),
        );

        pr.hide();
        final Map responseJson = json.decode(response.body);
        if (responseJson["rows"].length != 0) {
          userID = responseJson["rows"][0]["userID"];
          userName = responseJson["rows"][0]["userName"];
          appTypeID = responseJson["rows"][0]["appTypeID"];
          uEmail = responseJson["rows"][0]["email"];
          townID = responseJson["rows"][0]["townID"];

          navigateToSuccess(context);
        } else {
          Widget okButton = FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
              // navigateToHome(context);
            },
          );

          AlertDialog alert = AlertDialog(
            title: Text("Error!"),
            content: Text("Already Registered"),
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
    } catch (e) {
      print(e);
    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  //declarations
  Color blackClr = Color(0xff141622);
  Color greenClr = Color(0xff8cc540);
  Color blueClr = Color(0xff408cc5);
  Color bodyClr = Color(0xfff8f7f7);

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
      // autovalidate: true,
      child: Container(
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
                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          // icon: const Icon(Icons.color_lens),
                          // labelText: 'Select Province',
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: _province == '',
                        child: new DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            items: province_data.map((item) {
                              return DropdownMenuItem(
                                value: item['provinceID'].toString(),
                                child: new Text(item['provinceName']),
                              );
                            }).toList(),
                            hint: new Text('select province'),
                            onChanged: (newVal) {
                              setState(() {
                                _province = newVal;

                                district_data = List();
                                tehsil_data = List();
                                town_data = List();

                                _district = null;
                                _tehsil = null;
                                _town = null;

                                this.getDistrict(_province);
                              });
                            },
                            value: _province,
                          ),
                        ),
                      );
                    },
                    validator: (val) {
                      val = _province;
                      print(val);
                      if (val == "" || val == null) {
                        return 'Please Select Province';
                      }
                      // return val != "" ? null : 'Please Select Province';
                      return null;
                    },
                  ),
                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          // icon: const Icon(Icons.color_lens),
                          // labelText: 'Select Province',
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: _district == '',
                        child: new DropdownButtonHideUnderline(
                            child: DropdownButton(
                          isExpanded: true,
                          items: district_data.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item['districtName']),
                              value: item['districtID'].toString(),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              _district = newVal;

                              tehsil_data = List();
                              town_data = List();

                              _tehsil = null;
                              _town = null;

                              this.getTehsil(_district);
                            });
                          },
                          value: _district,
                          hint: new Text('select district'),
                        )),
                      );
                    },
                    validator: (val) {
                      val = _district;
                      print(val);
                      if (val == "" || val == null) {
                        return 'Please Select District';
                      }
                      // return val != "" ? null : 'Please Select Province';
                      return null;
                    },
                  ),
                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          // icon: const Icon(Icons.color_lens),
                          // labelText: 'Select Province',
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: _tehsil == '',
                        child: new DropdownButtonHideUnderline(
                            child: DropdownButton(
                          isExpanded: true,
                          items: tehsil_data.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item['tehsilName']),
                              value: item['tehsilID'].toString(),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              _tehsil = newVal;
                              this.getTown(_tehsil);
                            });
                          },
                          value: _tehsil,
                          hint: new Text('select tehsil'),
                        )),
                      );
                    },
                    validator: (val) {
                      val = _tehsil;
                      print(val);
                      if (val == "" || val == null) {
                        return 'Please Select Tehsil';
                      }
                      // return val != "" ? null : 'Please Select Province';
                      return null;
                    },
                  ),
                  new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          // icon: const Icon(Icons.color_lens),
                          // labelText: 'Select Province',
                          errorText: state.hasError ? state.errorText : null,
                        ),
                        isEmpty: _town == '',
                        child: new DropdownButtonHideUnderline(
                            child: DropdownButton(
                          isExpanded: true,
                          items: town_data.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item['townName']),
                              value: item['townID'].toString(),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              _town = newVal;
                            });
                          },
                          value: _town,
                          hint: new Text('select town'),
                        )),
                      );
                    },
                    validator: (val) {
                      val = _town;
                      print(val);
                      if (val == "" || val == null) {
                        return 'Please Select Town';
                      }
                      // return val != "" ? null : 'Please Select Province';
                      return null;
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 50, right: 50),
                    child: TextFormField(
                      controller: txtAddress,
                      key: Key('contactAddress'),
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintMaxLines: 4,
                        hintText: 'contact address',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Contact Address';
                        }
                        return null;
                      },
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
                      getProvince();
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
                      // print(_district);
                      // print(_province);
                      print(ownerName);
                      print(pwd);
                      print(usr);
                      print(mobileNumber);
                      print(email);
                      print(_town);
                      print(txtAddress.text);

                      registerContact();
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

  void navigateToSuccess(BuildContext context) {
    Routes.sailor.navigate(
      '/registerSuccess',
    );
  }
}
