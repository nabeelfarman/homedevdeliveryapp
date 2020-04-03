import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';

import '../Animation/FadeinAnimation.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword();

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
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: Key('userName'),
                      //textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'mobile number',
                        prefixIcon: Icon(Icons.phone_android),
                        // labelText: 'mobile number',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: Key('password'),
                      obscureText: true,
                      //textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'password',
                          prefixIcon: Icon(Icons.lock_outline)
                          // labelText: 'mobile number',
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      key: Key('confirmPassword'),
                      obscureText: true,
                      //textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'confirm password',
                          prefixIcon: Icon(Icons.done)
                          // labelText: 'mobile number',
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      elevation: 10,
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      color: greenClr,
                      splashColor: blackClr,
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Abel',
                        ),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
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
