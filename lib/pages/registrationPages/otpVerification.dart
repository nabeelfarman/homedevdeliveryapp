import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
//import 'package:flutter/services.dart';

class OTPVerification extends StatefulWidget {
  @override
  _OTPVerification createState() => _OTPVerification();
}

class _OTPVerification extends State<OTPVerification>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(minutes: 3));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Countdown(
            animation: StepTween(
              begin: 3 * 60,
              end: 0,
            ).animate(_controller),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Countdown extends AnimatedWidget {
  // _OTPVerification verification;

  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    //declarations
    Color blackClr = Color(0xff141622);
    Color greenClr = Color(0xff8cc540);
    Color blueClr = Color(0xff408cc5);
    Color bodyClr = Color(0xfff8f7f7);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Registration'),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: bodyClr,
        child: Stack(
          children: <Widget>[
            Column(
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
                          'REGISTRATION',
                          style: TextStyle(
                              color: greenClr,
                              fontSize: 40,
                              fontFamily: 'Abel'),
                        ),
                      )),
                ),
                FadeAnimation(
                  1.5,
                  Container(
                      height: 400,
                      child: Column(
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
                            '$timerText',
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
                              style:
                                  TextStyle(fontFamily: 'Baloo', fontSize: 18),
                            ),
                          ),
                          TextFormField(
                            key: Key('password'),
                            textAlign: TextAlign.center,
                            maxLength: 4,
                            decoration: InputDecoration(
                              hintText: '04 digit OTP',
                              // labelText: 'mobile number',
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 125, right: 125),
                            child: RaisedButton(
                              elevation: 10,
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(0),
                              ),
                              color: greenClr,
                              splashColor: blackClr,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child:
                                        Icon(Icons.done, color: Colors.white),
                                  ),
                                  Text(
                                    "Verify OTP",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Abel',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {
                                print('ok');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, right: 125, left: 125),
                            child: FadeAnimation(
                                2.5,
                                GestureDetector(
                                    child: Text("Resend  OTP",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Color(0xff408cc5),
                                            fontSize: 18)),
                                    onTap: () {
                                      // do what you need to do when "Click here" gets clicked
                                    })),
                          ),
                        ],
                      )),
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
                                  shape: BoxShape.circle,
                                  border: Border.all(color: blueClr)),
                            ),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: blueClr,
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
                        onPressed: () {},
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
