import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homemobileapp/pages/loginPage.dart';
import 'package:homemobileapp/pages/mainOTPVerification.dart';
import 'package:homemobileapp/pages/newOrder.dart';
import 'package:homemobileapp/pages/registrationPages/BusinessInfo.dart';
import 'package:homemobileapp/pages/registrationPages/contactInfo.dart';
import 'package:homemobileapp/pages/registrationPages/personalInfo.dart';
import 'package:homemobileapp/pages/registrationPages/registrationSuccess.dart';
import 'package:homemobileapp/pages/registrationPages/userNamePassword.dart';
import 'package:homemobileapp/pages/resetPassword.dart';
import 'package:homemobileapp/pages/customerPages/customerHome.dart';
import 'package:homemobileapp/sidebar/sidebar_layout.dart';
//import './UI/CustomLoginInput.dart';
// import './Animation/FadeinAnimation.dart';
// import './pages/registrationPages/otpVerification.dart';
import 'package:sailor/sailor.dart';

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
        primarySwatch: Colors.blue,
      ),
      // home: ContactInfo(),
      home: SplashScreen(),
      onGenerateRoute: Routes.sailor.generator(),
      navigatorKey: Routes.sailor.navigatorKey,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // print('ok1');
    Timer(
      Duration(seconds: 4),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => LoginPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(0xff8cc540)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Color(0xff8cc540),
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "FlutKart",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        Color(0xff141622),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Online Store \n For Everyone",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Routes {
  static final sailor = Sailor();
  static void createRoutes() {
    sailor.addRoutes([
      SailorRoute(
        name: '/login',
        builder: (context, args, params) {
          return LoginPage();
        },
      ),
      SailorRoute(
        name: '/verification',
        builder: (context, args, params) {
          return OTPVerification(
            mobileNumber: params.param('mobileNumber'),
            pwd: params.param('pwd'),
            pin: params.param<int>('pin'),
          );
        },
        params: [
          SailorParam<String>(name: 'mobileNumber', isRequired: true),
          SailorParam<String>(name: 'pwd', isRequired: true),
          SailorParam<int>(name: 'pin', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/register',
        builder: (context, args, params) {
          return UserNamePassword();
        },
      ),
      SailorRoute(
        name: '/supplier',
        builder: (context, args, params) {
          return SupplierCustomer(
            mobileNumber: params.param('mobileNumber'),
            pwd: params.param('pwd'),
            pin: params.param<int>('pin'),
          );
        },
        params: [
          SailorParam<String>(name: 'mobileNumber', isRequired: true),
          SailorParam<String>(name: 'pwd', isRequired: true),
          SailorParam<int>(name: 'pin', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/business',
        builder: (context, args, params) {
          return BusinessInfo(
            mobileNumber: params.param('mobileNumber'),
            pwd: params.param('pwd'),
            pin: params.param<int>('pin'),
            usr: params.param('usr'),
          );
        },
        params: [
          SailorParam<String>(name: 'mobileNumber', isRequired: true),
          SailorParam<String>(name: 'pwd', isRequired: true),
          SailorParam<int>(name: 'pin', isRequired: true),
          SailorParam<String>(name: 'usr', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/personal',
        builder: (context, args, params) {
          return PersonalInfo(
            mobileNumber: params.param('mobileNumber'),
            pwd: params.param('pwd'),
            pin: params.param<int>('pin'),
            usr: params.param('usr'),
          );
        },
        params: [
          SailorParam<String>(name: 'mobileNumber', isRequired: true),
          SailorParam<String>(name: 'pwd', isRequired: true),
          SailorParam<int>(name: 'pin', isRequired: true),
          SailorParam<String>(name: 'usr', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/contact',
        builder: (context, args, params) {
          return ContactInfo(
            mobileNumber: params.param('mobileNumber'),
            pwd: params.param('pwd'),
            pin: params.param<int>('pin'),
            usr: params.param('usr'),
            businessName: params.param('businessName'),
            ownerName: params.param('ownerName'),
            email: params.param('email'),
          );
        },
        params: [
          SailorParam<String>(name: 'mobileNumber', isRequired: true),
          SailorParam<String>(name: 'pwd', isRequired: true),
          SailorParam<int>(name: 'pin', isRequired: true),
          SailorParam<String>(name: 'usr', isRequired: true),
          SailorParam<String>(name: 'businessName'),
          SailorParam<String>(name: 'ownerName', isRequired: true),
          SailorParam<String>(name: 'email', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/registerSuccess',
        builder: (context, args, params) {
          return RegistrationSuccess();
        },
      ),
    ]);
  }
}
