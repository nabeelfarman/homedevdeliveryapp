import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_dialog/progress_dialog.dart';
import '../Animation/FadeinAnimation.dart';
import '../main.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword();

  _ResetPassword createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  TextEditingController mobile = new TextEditingController();
  TextEditingController pwd = new TextEditingController();
  TextEditingController cnfrmPwd = new TextEditingController();
  ProgressDialog pr;

  bool validateMobile = false;
  bool validatePwd = false;
  bool validateCnfrmPwd = false;

  Future<List> resetPassword() async {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    try {
      if (pwd.text != cnfrmPwd.text) {
        AlertDialog alert = AlertDialog(
          title: Text("Error!"),
          content: Text("Password & Confirm Password not Matched"),
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
        pr.show();

        http.Response response = await http.post(
          'http://95.217.147.105:2001/api/resetpw',
          headers: <String, String>{
            "Accept": "application/json",
            "content-type": "application/json"
          },
          body: jsonEncode(<String, String>{
            'UserName': mobile.text,
            'HashPassword': pwd.text
          }),
        );

        final Map responseJson = json.decode(response.body);
        pr.hide();
        print(responseJson['msg']);
        if (responseJson['msg'] == 'Success') {
          navigateToLogin(context);
        } else {
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
                // height: 80,
                padding: const EdgeInsets.only(top: 30),
                alignment: Alignment.bottomCenter,
                // color: blackClr,
                child: Text(
                  'RESET PASSWORD',
                  style: TextStyle(
                      color: blackClr, fontSize: 25, fontFamily: 'Anton'),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: mobile,
                          maxLength: 10,
                          key: Key('userName'),
                          keyboardType: TextInputType.number,
                          //textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0)),
                                  borderSide: new BorderSide(color: whiteClr)),
                              filled: true,
                              fillColor: whiteClr,
                              hintText: 'mobile number',
                              prefixIcon: Icon(
                                Icons.phone_android,
                                color: Colors.grey,
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
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: blackClr),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0)))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: pwd,
                          key: Key('password'),
                          maxLength: 15,
                          obscureText: true,
                          //textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0)),
                                  borderSide: new BorderSide(color: whiteClr)),
                              filled: true,
                              fillColor: whiteClr,
                              hintText: 'password',
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.grey,
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
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: blackClr),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0)))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: cnfrmPwd,
                          key: Key('confirmPassword'),
                          maxLength: 15,
                          obscureText: true,
                          //textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0)),
                                  borderSide: new BorderSide(color: whiteClr)),
                              filled: true,
                              fillColor: whiteClr,
                              hintText: 'confirm password',
                              prefixIcon: Icon(Icons.done),
                              errorText: validatePwd
                                  ? 'Confirm Password is Required'
                                  : null,
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
                                      const Radius.circular(40.0)))),
                        ),
                      ),
                      RaisedButton(
                        elevation: 5,
                        padding: EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 5.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20),
                        ),
                        color: redClr,
                        splashColor: greyClr,
                        child: Text(
                          "Reset Password",
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
                            cnfrmPwd.text.isEmpty
                                ? validateCnfrmPwd = true
                                : validateCnfrmPwd = false;
                            if (mobile.text.isNotEmpty &&
                                pwd.text.isNotEmpty &&
                                cnfrmPwd.text.isNotEmpty) {
                              resetPassword();
                            }
                          });
                        },
                      )
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
                    navigateToLogin(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  void navigateToLogin(BuildContext context) {
    Routes.sailor.navigate('/login');
  }
}
