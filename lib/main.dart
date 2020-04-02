import 'package:flutter/material.dart';
import 'package:homemobileapp/pages/loginPage.dart';
import 'package:homemobileapp/pages/registrationPages/userNamePassword.dart';
//import './UI/CustomLoginInput.dart';
import './Animation/FadeinAnimation.dart';
import './pages/registrationPages/otpVerification.dart';
import 'package:sailor/sailor.dart';

import 'pages/registrationPages/otpVerification.dart';
import 'pages/registrationPages/otpVerification.dart';
import 'pages/registrationPages/supplierCustomer.dart';

void main() {
  Routes.createRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Home Delivery'),
      home: OTPVerification(),
      // onGenerateRoute: Routes.sailor.generator(),
      // navigatorKey: Routes.sailor.navigatorKey,
    );
  }
}

// void f(int x) {}

class Routes {
  static final sailor = Sailor();
  static void createRoutes() {
    sailor.addRoutes([
      SailorRoute(
        name: '/login',
        builder: (context, args, params) {
          return UserNamePassword();
        },
      ),
      SailorRoute(
        name: '/verification',
        builder: (context, args, params) {
          return OTPVerification();
        },
      ),
      SailorRoute(
        name: '/user',
        builder: (context, args, params) {
          return UserNamePassword();
        },
      )
    ]);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xfff8f7f7),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  widthFactor: 0.5,
                  heightFactor: 0.6,
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.all(Radius.circular(200)),
                    color: Color(0xff141622),
                    child: FadeAnimation(
                        1.0,
                        Container(
                          width: 400,
                          height: 400,
                        )),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 80, left: 85),
                      child: FadeAnimation(
                          1,
                          Container(
                            height: 180,
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Color(0xff8cc540),
                                  fontSize: 40,
                                  fontFamily: 'Abel'),
                            ),
                          )),
                    ),
                    Container(
                      height: 420,
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Material(
                              elevation: 10,
                              child: FadeAnimation(
                                  1.25,
                                  Container(
                                      alignment: Alignment.topCenter,
                                      width: 70,
                                      height: 70,
                                      color: Color(0xff141622))),
                            ),
                          ),
                          Material(
                            elevation: 10,
                            child: FadeAnimation(
                                1.5,
                                Container(
                                  width: 350,
                                  height: 170,
                                  color: Colors.white,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: TextFormField(
                                            key: Key('password'),
                                            decoration: InputDecoration(
                                              hintText: 'mobile number',
                                              // labelText: 'mobile number',
                                              prefixIcon:
                                                  Icon(Icons.phone_android),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20, top: 20),
                                          child: TextFormField(
                                              key: Key('username'),
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  hintText: 'password',
                                                  // labelText: 'password',
                                                  prefixIcon: Icon(
                                                      Icons.lock_outline))),
                                        ),
                                      ]),
                                )),
                          ),
                          Container(
                            width: 350,
                            height: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: FadeAnimation(
                                          2.0,
                                          RaisedButton(
                                            elevation: 5,
                                            padding: EdgeInsets.fromLTRB(
                                                50.0, 10.0, 50.0, 10.0),
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(0),
                                            ),
                                            color: Color(0xff8cc540),
                                            splashColor: Color(0xff141622),
                                            child: Text(
                                              "Login...",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onPressed: () {
                                              navigateToHome(context);
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: FadeAnimation(
                                          2.5,
                                          GestureDetector(
                                              child: Text("new registeration",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Color(0xff141622),
                                                      fontSize: 18)),
                                              onTap: () {
                                                // do what you need to do when "Click here" gets clicked
                                              })),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: FadeAnimation(
                                          2.5,
                                          GestureDetector(
                                              child: Text("forget password",
                                                  style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Color(0xff408cc5),
                                                      fontSize: 18)),
                                              onTap: () {
                                                // do what you need to do when "Click here" gets clicked
                                              })),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            )) // contaienr
        );
  }

  void navigateToHome(BuildContext context) {
    Routes.sailor.navigate('/verification');
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => OTPVerification(),
    // ));
  }
}
