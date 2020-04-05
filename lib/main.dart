import 'package:flutter/material.dart';
import 'package:homemobileapp/pages/loginPage.dart';
import 'package:homemobileapp/pages/mainOTPVerification.dart';
import 'package:homemobileapp/pages/registrationPages/BusinessInfo.dart';
import 'package:homemobileapp/pages/registrationPages/contactInfo.dart';
import 'package:homemobileapp/pages/registrationPages/personalInfo.dart';
import 'package:homemobileapp/pages/registrationPages/registrationSuccess.dart';
import 'package:homemobileapp/pages/registrationPages/userNamePassword.dart';
import 'package:homemobileapp/pages/resetPassword.dart';
import 'package:homemobileapp/pages/supplierSelection.dart';
import 'package:homemobileapp/sidebar/sidebar_layout.dart';
//import './UI/CustomLoginInput.dart';
// import './Animation/FadeinAnimation.dart';
import './pages/registrationPages/otpVerification.dart';
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
      //home: MyHomePage(title: 'Home Delivery'),
      home: SideBarLayout(),
      // onGenerateRoute: Routes.sailor.generator(),
      // navigatorKey: Routes.sailor.navigatorKey,
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
          return OTPVerification();
        },
      ),
      SailorRoute(
        name: '/user',
        builder: (context, args, params) {
          return UserNamePassword();
        },
      ),
      SailorRoute(
        name: '/supplier',
        builder: (context, args, params) {
          return SupplierCustomer();
        },
      )
    ]);
  }
}

void navigateToHome(BuildContext context) {
  Routes.sailor.navigate('/verification');
  // Navigator.of(context).push(MaterialPageRoute(
  //   builder: (context) => OTPVerification(),
  // ));
}
