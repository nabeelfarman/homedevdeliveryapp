import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/bottom_bar.dart';
import 'package:homemobileapp/UI/home_card.dart';
import 'package:homemobileapp/UI/image_carousel.dart';
import 'package:homemobileapp/navigationBloc/navigationBlock.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:badges/badges.dart';
import '../../main.dart';

class CustomerHome extends StatefulWidget with NavigationStates {
  final int userID;
  final int townID;

  @override
  CustomerHome({
    @required this.userID,
    @required this.townID,
  });

  @override
  _CustomerHomeState createState() =>
      _CustomerHomeState(this.userID, this.townID);
}

class _CustomerHomeState extends State<CustomerHome> {
  String pageName;
  int userID;
  int townID;
  int totalItems = 0;

  List supplierList = [];
  ProgressDialog pr;

  @override
  _CustomerHomeState(this.userID, this.townID);

  @override
  void initState() {
    super.initState();
    print(userID);
    this.getCartItems();
    getMerchants();
  }

  Future<String> getMerchants() async {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    try {
      // Future.delayed(Duration(seconds: 1)).then((value) {
      //   pr.show();
      // });

      var response = await http.get(
          "http://95.217.147.105:2001/api/getmerchantintown?TownID=" +
              townID.toString(),
          headers: {
            "Content-Type": "application/json",
          });

      var responseJson = json.decode(response.body);

      for (int i = 0; i < responseJson.length; i++) {
        supplierList.add({
          'id': responseJson[i]["merchantID"],
          'title': responseJson[i]["companyName"],
          'address': responseJson[i]["townName"],
          'category': responseJson[i]["businessID"],
          'active': true,
        });
      }

      // this.dispose();

      // _tabController = TabController(length: categoryList.length, vsync: this);

      // Future.delayed(Duration(seconds: 2)).then((value) {
      //   pr.hide();
      // });
    } catch (e) {
      // Future.delayed(Duration(seconds: 2)).then((value) {
      //   pr.hide();
      // });

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

  @override
  Future<String> getCartItems() async {
    try {
      Future.delayed(Duration(seconds: 1)).then((value) {
        pr.show();
      });
      var response = await http.get(
          "http://95.217.147.105:2001/api/getcartprod?CustomerID=" +
              userID.toString(),
          headers: {
            "Content-Type": "application/json",
          });
      var responseJson = json.decode(response.body);

      setState(() {
        totalItems = responseJson.length;
      });

      Future.delayed(Duration(seconds: 2)).then((value) {
        pr.hide();
      });

      return 'success';
    } catch (e) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        pr.hide();
      });

      print(e);
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
    // pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    // pr.style(
    //   message: 'Please Wait...',
    //   borderRadius: 10.0,
    //   backgroundColor: blackClr,
    //   progressWidget: CircularProgressIndicator(
    //     valueColor: new AlwaysStoppedAnimation<Color>(lightYellowClr),
    //   ),
    //   elevation: 20.0,
    //   insetAnimCurve: Curves.easeInOut,
    //   progress: 0.0,
    //   maxProgress: 100.0,
    //   progressTextStyle: TextStyle(
    //       color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w400),
    //   messageTextStyle: TextStyle(
    //       color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w600),
    // );

    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: darkYellowClr,
        title: Text('Home Delivery',
            style:
                TextStyle(color: blackClr, fontFamily: 'Anton', fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          constraints: new BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100),
          decoration: new BoxDecoration(
            // color: yellowClr,
            gradient: new LinearGradient(
                colors: [darkYellowClr, lightYellowClr, yellowClr],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * (2 / 7),
                child: ImageCarousel(),
              ),
              Container(
                height: MediaQuery.of(context).size.height * (3.7 / 7),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    GestureDetector(
                      child: HomeCard(
                        icon: Icons.assignment,
                        iconTitle: 'New Order',
                        cardColor: redClr,
                      ),
                      onTap: () {
                        navigateToNewOrder(context);
                        // BlocProvider.of<NavigationBloc>(context).add(newOrder(
                        //   userID: userID,
                        //   townID: townID,
                        // ));
                      },
                    ),
                    GestureDetector(
                      child: HomeCard(
                        icon: Icons.history,
                        iconTitle: 'History',
                        cardColor: greenClr,
                      ),
                      onTap: () {
                        pageName = "History";
                        navigateToCustomerOrder(context);
                      },
                    ),
                    GestureDetector(
                      child: HomeCard(
                        icon: Icons.slow_motion_video,
                        iconTitle: 'in-Process',
                        cardColor: greenClr,
                      ),
                      onTap: () {
                        pageName = "inProcess";
                        navigateToCustomerOrder(context);
                      },
                    ),
                    GestureDetector(
                      child: HomeCard(
                        icon: Icons.airport_shuttle,
                        iconTitle: 'Delivery',
                        cardColor: redClr,
                      ),
                      onTap: () {
                        pageName = "Delivery";
                        navigateToCustomerOrder(context);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToShoppingCart(context);
        },
        backgroundColor: blackClr,
        child: totalItems != 0
            ? Badge(
                child: Icon(
                  Icons.shopping_cart,
                  color: lightYellowClr,
                ),
                badgeContent: Text(
                  totalItems.toString(),
                ),
                badgeColor: Colors.white,
                animationType: BadgeAnimationType.scale,
              )
            : Icon(
                Icons.shopping_cart,
                color: lightYellowClr,
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: yellowClr,
      bottomNavigationBar: BottomBar(pageName),
    );
  }

  void navigateToNewOrder(BuildContext context) {
    Routes.sailor.navigate(
      '/newOrder',
      params: {
        'userID': userID,
        'townID': townID,
        'supplierList': supplierList,
      },
    );
  }

  void navigateToCustomerOrder(BuildContext context) {
    Routes.sailor.navigate(
      '/customerOrder',
      params: {
        'pageName': pageName,
        'userID': userID,
        'townID': townID,
      },
    );
  }

  void navigateToShoppingCart(BuildContext context) {
    Routes.sailor.navigate(
      '/shoppingCart',
      params: {
        'customerID': userID,
      },
    );
  }
}
