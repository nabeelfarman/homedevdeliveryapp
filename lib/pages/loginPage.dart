import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';

import '../Animation/FadeinAnimation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with SingleTickerProviderStateMixin {
  // AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    //declarations
    Color blackClr = Color(0xff141622);
    Color greenClr = Color(0xff8cc540);
    Color blueClr = Color(0xff408cc5);
    Color bodyClr = Color(0xfff8f7f7);

    return MaterialApp(
        home: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: bodyClr,
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.bottomCenter,
                widthFactor: 0.5,
                heightFactor: 0.6,
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  color: blackClr,
                  child: FadeAnimation(
                      1.0,
                      Container(
                        width: 400,
                        height: 400,
                      )),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 85),
              child: FadeAnimation(
                  1.0,
                  Text('LOGIN',
                      style: TextStyle(
                          color: bodyClr, fontSize: 40, fontFamily: 'Abel'))),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: FadeAnimation(
                      1.5,
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Icon(
                          Icons.shopping_basket,
                          color: blueClr,
                          size: 70,
                        ),
                      )),
                ),
                Center(
                  child: FadeAnimation(
                    2.0,
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Material(
                        elevation: 5,
                        child: Container(
                          width: 300,
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: TextFormField(
                                  key: Key('mobileNumber'),
                                  decoration: InputDecoration(
                                    hintText: 'mobile number',
                                    // labelText: 'mobile number',
                                    prefixIcon: Icon(Icons.phone_android),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: TextFormField(
                                  key: Key('password'),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'password',
                                    // labelText: 'mobile number',
                                    prefixIcon: Icon(Icons.lock_outline),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: FadeAnimation(
                        2.5,
                        RaisedButton(
                          elevation: 5,
                          padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10),
                          ),
                          color: Color(0xff8cc540),
                          splashColor: Color(0xff141622),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Abel',
                            ),
                          ),
                          onPressed: () {},
                        )),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: 300,
                  height: 50,
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
                                    color: blackClr,
                                    fontSize: 16,
                                    fontFamily: 'Baloo')),
                            GestureDetector(
                                child: Text("Register",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: greenClr,
                                        fontSize: 18,
                                        fontFamily: 'Abel')),
                                onTap: () {
                                  // do what you need to do when "Click here" gets clicked
                                }),
                          ],
                        ),
                      ),
                      GestureDetector(
                          child: Text("forget password",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: blueClr,
                                  fontSize: 18,
                                  fontFamily: 'Abel')),
                          onTap: () {
                            // do what you need to do when "Click here" gets clicked
                          }),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
