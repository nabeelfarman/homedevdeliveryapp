import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/bottom_bar.dart';
import 'package:homemobileapp/sidebar/sidebar_layout.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';

class CustomerOrders extends StatefulWidget {
  final String pageName;
  final int userID;
  final int townID;

  @override
  CustomerOrders({
    @required this.pageName,
    @required this.userID,
    @required this.townID,
  });

  @override
  _CustomerOrdersState createState() => _CustomerOrdersState(
        this.pageName,
        this.userID,
        this.townID,
      );
}

class _CustomerOrdersState extends State<CustomerOrders>
    with SingleTickerProviderStateMixin {
  Color blackClr = Color(0xff1D2028);

  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0ffEEF2F5);
  Color greyClr = Color(0x0ffB5BED0);
  Color greenClr = Color(0x0ffA3C12E);
  Color redClr = Color(0x0ffcf3f3d);

  Color yellowClr = Color(0x0ffF8D247);
  Color darkYellowClr = Color(0x0ffdfbd3f);
  Color lightYellowClr = Color(0x0ffffde22);

  String pageName;
  int userID;
  int townID;
  String orderNo;
  String supplier;
  String address;
  String status;
  int totalItems = 0;

  String userName;
  int appTypeID;
  String email;

  _CustomerOrdersState(
    this.pageName,
    this.userID,
    this.townID,
  );

  List customer_orders = [];

  List customerOrdersList = List();
  final formatter = new NumberFormat('##,###.##');
  bool isSearching = false;
  Color foreColor;
  Color bgColor;

  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    this.getCustomerOrders();
    this.getCartItems();
    this.getUserData();
  }

  @override
  Future<String> getUserData() async {
    try {
      // Future.delayed(Duration(seconds: 1)).then((value) {
      //   pr.show();
      // });
      var response = await http.get(
          "http://95.217.147.105:2001/api/getuserdetail?UserID=" +
              userID.toString(),
          headers: {
            "Content-Type": "application/json",
          });
      var responseJson = json.decode(response.body);

      userID = responseJson[0]["userID"];
      userName = responseJson[0]["userName"];
      appTypeID = responseJson[0]["appTypeID"];
      email = responseJson[0]["email"];
      townID = responseJson[0]["townID"];

      // Future.delayed(Duration(seconds: 2)).then((value) {
      //   pr.hide();
      // });

      return 'success';
    } catch (e) {
      // Future.delayed(Duration(seconds: 2)).then((value) {
      //   pr.hide();
      // });

      print(e);
    }
  }

  @override
  Future<String> getCartItems() async {
    try {
      // Future.delayed(Duration(seconds: 1)).then((value) {
      //   pr.show();
      // });
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

      // Future.delayed(Duration(seconds: 2)).then((value) {
      //   pr.hide();
      // });

      return 'success';
    } catch (e) {
      // Future.delayed(Duration(seconds: 2)).then((value) {
      //   pr.hide();
      // });

      print(e);
    }
  }

  @override
  void _filteredOrders(String searchText) {
    try {
      setState(() {
        customerOrdersList = customer_orders
            .where((item) => item['supplier']
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<String> getCustomerOrders() async {
    try {
      Future.delayed(Duration(seconds: 1)).then((value) {
        pr.show();
      });

      var response = await http.get(
          "http://95.217.147.105:2001/api/getcusorders?CustomerID=" +
              userID.toString(),
          headers: {
            "Content-Type": "application/json",
          });

      var responseJson = json.decode(response.body);

      for (int i = 0; i < responseJson.length; i++) {
        String orderStatus = "";
        if (responseJson[i]["oStatus"] == 1 &&
            responseJson[i]["cStatus"] == 0 &&
            responseJson[i]["dStatus"] == 0) {
          orderStatus = "Pending";
        } else if (responseJson[i]["oStatus"] == 2 &&
            responseJson[i]["cStatus"] == 0 &&
            responseJson[i]["dStatus"] == 0) {
          orderStatus = "Cancelled";
        } else if (responseJson[i]["oStatus"] == 1 &&
            responseJson[i]["cStatus"] == 1 &&
            responseJson[i]["dStatus"] == 0) {
          orderStatus = "Confirmed";
        } else if (responseJson[i]["oStatus"] == 1 &&
            responseJson[i]["cStatus"] == 2 &&
            responseJson[i]["dStatus"] == 0) {
          orderStatus = "Rejected";
        } else if (responseJson[i]["oStatus"] == 1 &&
            responseJson[i]["cStatus"] == 1 &&
            responseJson[i]["dStatus"] == 1) {
          orderStatus = "Completed";
        }
        if (pageName == "inProcess" && orderStatus == "Confirmed") {
          customer_orders.add({
            'orderNo': responseJson[i]["orderID"].toString(),
            'customerID': responseJson[i]["customerID"].toString(),
            'merchantID': responseJson[i]["merchantID"].toString(),
            'supplier': responseJson[i]["companyName"],
            'address': responseJson[i]["address"],
            'totalAmount': responseJson[i]["totalAmount"].toString(),
            'orderStatus': orderStatus,
          });
        } else if (pageName == "Delivery" && orderStatus == "Completed") {
          customer_orders.add({
            'orderNo': responseJson[i]["orderID"].toString(),
            'customerID': responseJson[i]["customerID"].toString(),
            'merchantID': responseJson[i]["merchantID"].toString(),
            'supplier': responseJson[i]["companyName"],
            'address': responseJson[i]["address"],
            'totalAmount': responseJson[i]["totalAmount"].toString(),
            'orderStatus': orderStatus,
          });
        } else if (pageName == "History") {
          customer_orders.add({
            'orderNo': responseJson[i]["orderID"].toString(),
            'customerID': responseJson[i]["customerID"].toString(),
            'merchantID': responseJson[i]["merchantID"].toString(),
            'supplier': responseJson[i]["companyName"],
            'address': responseJson[i]["address"],
            'totalAmount': responseJson[i]["totalAmount"].toString(),
            'orderStatus': orderStatus,
          });
        }
      }

      setState(() {
        customerOrdersList = customer_orders;
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

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
      message: 'Please Wait...',
      borderRadius: 10.0,
      backgroundColor: blackClr,
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(lightYellowClr),
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
      appBar: new AppBar(
        leading: GestureDetector(
          onTap: () {
            print(userID);
            print(townID);
            print(pageName);
            navigateToSideBarLayout(context);
          },
          child: Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: darkYellowClr,
        title: !isSearching
            ? Text('Your Orders',
                style: TextStyle(
                    color: blackClr, fontFamily: 'Anton', fontSize: 25))
            : TextField(
                onChanged: (Text) {
                  // supplierListPage.prinText(value);
                  _filteredOrders(Text);
                  // _tabController.animateTo(_tabController.index - 1);
                },
                style: TextStyle(color: redClr),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: redClr,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: redClr)),
                    hintText: 'search order by supplier name',
                    hintStyle: TextStyle(
                        color: redClr, fontFamily: 'Baloo', fontSize: 18))),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                    });
                  },
                  color: redClr)
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                  color: redClr)
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 160.0,
            width: double.infinity,
            decoration: new BoxDecoration(
              // color: yellowClr,
              gradient: new LinearGradient(
                  colors: [darkYellowClr, lightYellowClr, yellowClr],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: new ListView.builder(
              itemCount: customerOrdersList.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildOrderCard(context, index),
            ),
          )
        ],
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
      backgroundColor: lightYellowClr,
      bottomNavigationBar: BottomBar(
        pageName,
      ),
    );
  }

  // orders widget
  Widget buildOrderCard(BuildContext context, int index) {
    final item = customerOrdersList[index];
    return FadeAnimation(
      1.5,
      Card(
          color: whiteClr,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(item['supplier'],
                        style: TextStyle(
                            color: blackClr,
                            fontFamily: 'Baloo',
                            fontSize: 18,
                            fontWeight: FontWeight.w800)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item['address'],
                      style: TextStyle(
                          color: blackClr, fontFamily: 'Baloo', fontSize: 18),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        'Rs. ' +
                            formatter.format(double.parse(item['totalAmount'])),
                        style: TextStyle(
                            color: blackClr,
                            fontFamily: 'Baloo',
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                    item['orderStatus'] == 'Pending'
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.yellowAccent),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                item['orderStatus'],
                                style: TextStyle(
                                    color: blackClr,
                                    fontFamily: 'Baloo',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : item['orderStatus'] == 'Completed'
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: greenClr),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Text(
                                    item['orderStatus'],
                                    style: TextStyle(
                                        color: blackClr,
                                        fontFamily: 'Baloo',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            : item['orderStatus'] == 'Confirmed'
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.orange),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Text(
                                        item['orderStatus'],
                                        style: TextStyle(
                                            color: blackClr,
                                            fontFamily: 'Baloo',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: redClr),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Text(
                                        item['orderStatus'],
                                        style: TextStyle(
                                            color: whiteClr,
                                            fontFamily: 'Baloo',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                    GestureDetector(
                      child: Text("Details...",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: redClr,
                              fontSize: 18,
                              fontFamily: 'Baloo')),
                      onTap: () {
                        orderNo = item["orderNo"];
                        supplier = item["supplier"];
                        address = item["address"];
                        status = item["orderStatus"];

                        navigateToOrderDetail(context);
                      },
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  void navigateToSideBarLayout(BuildContext context) {
    Routes.sailor.navigate(
      '/sideBarLayout',
      params: {
        'userID': userID,
        'userName': userName,
        'appTypeID': appTypeID,
        'email': email,
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

  void navigateToOrderDetail(BuildContext context) {
    Routes.sailor.navigate(
      '/orderDetail',
      params: {
        'pageName': pageName,
        'townID': townID,
        'userID': userID,
        'orderNo': orderNo,
        'supplier': supplier,
        'address': address,
        'status': status,
      },
    );
  }
}
