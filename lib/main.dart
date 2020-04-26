import 'dart:async';
import 'package:flutter/material.dart';
import 'package:homemobileapp/pages/customerPages/customerOrderDetails.dart';
import 'package:homemobileapp/pages/customerPages/customerOrders.dart';
import 'package:homemobileapp/pages/customerPages/orderPlacement.dart';
import 'package:homemobileapp/pages/customerPages/shoppingCart.dart';
import 'package:homemobileapp/pages/loginPage.dart';
import 'package:homemobileapp/pages/newOrder.dart';
import 'package:homemobileapp/pages/registrationPages/BusinessInfo.dart';
import 'package:homemobileapp/pages/registrationPages/contactInfo.dart';
import 'package:homemobileapp/pages/registrationPages/personalInfo.dart';
import 'package:homemobileapp/pages/registrationPages/registrationSuccess.dart';
import 'package:homemobileapp/pages/registrationPages/userNamePassword.dart';
import 'package:homemobileapp/pages/resetPassword.dart';
import 'package:homemobileapp/pages/customerPages/customerHome.dart';
import 'package:homemobileapp/pages/supplierPages/inventory.dart';
import 'package:homemobileapp/pages/supplierPages/supplierOrderDetails.dart';
import 'package:homemobileapp/pages/supplierPages/supplierOrders.dart';
import 'package:homemobileapp/sidebar/sidebar_layout.dart';
//import './UI/CustomLoginInput.dart';
// import './Animation/FadeinAnimation.dart';
// import './pages/registrationPages/otpVerification.dart';
import 'package:sailor/sailor.dart';

import 'package:homemobileapp/pages/customerPages/itemsPage.dart';
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
      // home: SideBarLayout(),
      home: SplashScreen(),
      //home: SideBarLayout(),
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
        name: '/customerHome',
        builder: (context, args, params) {
          return CustomerHome(
            userID: params.param<int>('userID'),
            townID: params.param<int>('townID'),
          );
        },
        params: [
          SailorParam<int>(name: 'userID', isRequired: true),
          SailorParam<String>(name: 'townID', isRequired: true),
        ],
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
            natureList: params.param('natureList'),
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
          SailorParam(name: 'natureList'),
        ],
      ),
      SailorRoute(
        name: '/registerSuccess',
        builder: (context, args, params) {
          return RegistrationSuccess(
            userID: params.param<int>('userID'),
            userName: params.param('userName'),
            appTypeID: params.param<int>('appTypeID'),
            email: params.param('email'),
            townID: params.param('townID'),
          );
        },
        params: [
          SailorParam<int>(name: 'userID', isRequired: true),
          SailorParam<String>(name: 'userName', isRequired: true),
          SailorParam<int>(name: 'appTypeID', isRequired: true),
          SailorParam<int>(name: 'email', isRequired: true),
          SailorParam<String>(name: 'townID', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/newOrder',
        builder: (context, args, params) {
          return NewOrderPage(
            userID: params.param<int>('userID'),
            townID: params.param<int>('townID'),
          );
        },
        params: [
          SailorParam<int>(name: 'userID', isRequired: true),
          SailorParam<int>(name: 'townID', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/sideBarLayout',
        builder: (context, args, params) {
          return SideBarLayout(
            userID: params.param<int>('userID'),
            userName: params.param('userName'),
            appTypeID: params.param<int>('appTypeID'),
            email: params.param('email'),
            townID: params.param('townID'),
          );
        },
        params: [
          SailorParam<int>(name: 'userID', isRequired: true),
          SailorParam<String>(name: 'userName', isRequired: true),
          SailorParam<int>(name: 'appTypeID', isRequired: true),
          SailorParam<String>(name: 'email', isRequired: true),
          SailorParam<String>(name: 'townID', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/item',
        builder: (context, args, params) {
          return ItemsPage(
            supplierID: params.param<int>('supplierID'),
            userID: params.param<int>('userID'),
            businessID: params.param<int>('businessID'),
          );
        },
        params: [
          SailorParam<int>(name: 'supplierID', isRequired: true),
          SailorParam<int>(name: 'userID', isRequired: true),
          SailorParam<int>(name: 'businessID', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/shoppingCart',
        builder: (context, args, params) {
          return ShoppingCart(
            customerID: params.param<int>('customerID'),
          );
        },
        params: [
          SailorParam<int>(name: 'customerID', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/forgotPassword',
        builder: (context, args, params) {
          return ResetPassword();
        },
      ),
      SailorRoute(
        name: '/customerOrder',
        builder: (context, args, params) {
          return CustomerOrders(
            pageName: params.param<String>('pageName'),
            userID: params.param<int>('userID'),
            townID: params.param<int>('townID'),
          );
        },
        params: [
          SailorParam<String>(name: 'pageName', isRequired: true),
          SailorParam<int>(name: 'userID', isRequired: true),
          SailorParam<int>(name: 'townID', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/supplierOrder',
        builder: (context, args, params) {
          return SupplierOrders(
            pageName: params.param<String>('pageName'),
            userID: params.param<int>('userID'),
            townID: params.param<int>('townID'),
          );
        },
        params: [
          SailorParam<String>(name: 'pageName', isRequired: true),
          SailorParam<int>(name: 'userID', isRequired: true),
          SailorParam<int>(name: 'townID', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/orderDetail',
        builder: (context, args, params) {
          return CustomerOrderDetail(
            pageName: params.param<String>('pageName'),
            orderNo: params.param<String>('orderNo'),
            supplier: params.param<String>('supplier'),
            address: params.param<String>('address'),
            status: params.param<String>('status'),
          );
        },
        params: [
          SailorParam<String>(name: 'pageName', isRequired: true),
          SailorParam<String>(name: 'orderNo', isRequired: true),
          SailorParam<String>(name: 'supplier', isRequired: true),
          SailorParam<String>(name: 'address', isRequired: true),
          SailorParam<String>(name: 'status', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/supplierOrderDetail',
        builder: (context, args, params) {
          return SupplierOrderDetails(
            pageName: params.param<String>('pageName'),
            orderNo: params.param<String>('orderNo'),
            customer: params.param<String>('customer'),
            address: params.param<String>('address'),
            status: params.param<String>('status'),
          );
        },
        params: [
          SailorParam<String>(name: 'pageName', isRequired: true),
          SailorParam<String>(name: 'orderNo', isRequired: true),
          SailorParam<String>(name: 'customer', isRequired: true),
          SailorParam<String>(name: 'address', isRequired: true),
          SailorParam<String>(name: 'status', isRequired: true),
        ],
      ),
      SailorRoute(
        name: '/inventory',
        builder: (context, args, params) {
          return InventoryPage();
        },
      ),
      SailorRoute(
        name: '/orderPlacement',
        builder: (context, args, params) {
          return OrderPlacement();
        },
      ),
    ]);
  }
}
