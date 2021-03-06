import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';

class MainOTPVerification extends StatelessWidget {
  MainOTPVerification();

  //declaration
  Color blackClr = Color(0xff141622);
  Color greenClr = Color(0xff8cc540);
  Color blueClr = Color(0xff408cc5);
  Color bodyClr = Color(0xfff8f7f7);

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
                    'Reset Password',
                    style: TextStyle(
                        color: greenClr, fontSize: 40, fontFamily: 'Abel'),
                  ),
                )),
          ),
          FadeAnimation(
            1.5,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: Icon(
                    Icons.alarm,
                    size: 80,
                    color: blueClr,
                  ),
                ),
                Text(
                  '3:00',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: blackClr,
                      fontSize: 30,
                      fontFamily: 'Josefin',
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Text(
                    'One Time Password  (OTP) has been sent to your registered mobile number. Please enter  One Time Password (OTP) within the stipulated time.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Baloo', fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: TextFormField(
                    key: Key('password'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 4,
                    decoration: InputDecoration(
                      hintText: '04 digit OTP',
                      // labelText: 'mobile number',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter Verification Code';
                      }
                    },
                    onSaved: (String value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 125, right: 125),
                  child: RaisedButton(
                    elevation: 10,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    color: greenClr,
                    splashColor: blackClr,
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Abel',
                      ),
                    ),
                    onPressed: () {},
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
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
