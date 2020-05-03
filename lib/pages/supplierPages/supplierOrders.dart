import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/supplier_bottom_bar.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';

class SupplierOrders extends StatefulWidget {
  final String pageName;
  final int userID;
  final int townID;

  @override
  SupplierOrders({
    @required this.pageName,
    @required this.userID,
    @required this.townID,
  });

  @override
  _SupplierOrdersState createState() => _SupplierOrdersState(
        this.pageName,
        this.userID,
        this.townID,
      );
}

class _SupplierOrdersState extends State<SupplierOrders>
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

  String userName;
  int appTypeID;
  String email;

  ProgressDialog pr;

  _SupplierOrdersState(
    this.pageName,
    this.userID,
    this.townID,
  );

  List supplier_orders = [];

  List supplierOrdersList = List();
  final formatter = new NumberFormat('##,###.##');
  bool isSearching = false;
  Color foreColor;
  Color bgColor;

  @override
  void initState() {
    super.initState();

    print(pageName);
    this.getSupplierOrders();
    getUserData();
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
  void _filteredOrders(String searchText) {
    try {
      setState(() {
        supplierOrdersList = supplier_orders
            .where((item) => item['customer']
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<String> getSupplierOrders() async {
    try {
      Future.delayed(Duration(seconds: 1)).then((value) {
        pr.show();
      });

      var response = await http.get(
          "http://95.217.147.105:2001/api/getsuporders?MerchantID=" +
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
          supplier_orders.add({
            'orderNo': responseJson[i]["orderID"].toString(),
            'customerID': responseJson[i]["customerID"].toString(),
            'merchantID': responseJson[i]["merchantID"].toString(),
            'customer': responseJson[i]["customerName"],
            'address': responseJson[i]["address"],
            'totalAmount': responseJson[i]["totalAmount"].toString(),
            'orderStatus': orderStatus,
          });
        } else if (pageName == "Delivery" && orderStatus == "Completed") {
          supplier_orders.add({
            'orderNo': responseJson[i]["orderID"].toString(),
            'customerID': responseJson[i]["customerID"].toString(),
            'merchantID': responseJson[i]["merchantID"].toString(),
            'customer': responseJson[i]["customerName"],
            'address': responseJson[i]["address"],
            'totalAmount': responseJson[i]["totalAmount"].toString(),
            'orderStatus': orderStatus,
          });
        } else if (pageName == "Orders") {
          supplier_orders.add({
            'orderNo': responseJson[i]["orderID"].toString(),
            'customerID': responseJson[i]["customerID"].toString(),
            'merchantID': responseJson[i]["merchantID"].toString(),
            'customer': responseJson[i]["customerName"],
            'address': responseJson[i]["address"],
            'totalAmount': responseJson[i]["totalAmount"].toString(),
            'orderStatus': orderStatus,
          });
        }
      }

      setState(() {
        supplierOrdersList = supplier_orders;
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
                    color: blackClr, fontFamily: 'Josefin', fontSize: 25))
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
                    hintText: 'search order by customer name',
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
            height: MediaQuery.of(context).size.height - 50.0,
            decoration: new BoxDecoration(
              // color: yellowClr,
              gradient: new LinearGradient(
                  colors: [darkYellowClr, lightYellowClr, yellowClr],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            width: double.infinity,
            child: new ListView.builder(
              itemCount: supplierOrdersList.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildOrderCard(context, index),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: blackClr,
        child: Icon(Icons.notifications, color: lightYellowClr),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: lightYellowClr,
      bottomNavigationBar: SupplierBottomBar(),
    );
  }

  // orders widget
  Widget buildOrderCard(BuildContext context, int index) {
    final item = supplierOrdersList[index];
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
                    Text(item['customer'],
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
                          supplier = item["customer"];
                          address = item["address"];
                          status = item['orderStatus'];
                          navigateToSupplierOrderDetail(context);
                        })
                  ],
                )
              ],
            ),
          )),
    );
  }

  void navigateToSupplierOrderDetail(BuildContext context) {
    Routes.sailor.navigate(
      '/supplierOrderDetail',
      params: {
        'pageName': pageName,
        'townID': townID,
        'userID': userID,
        'orderNo': orderNo,
        'customer': supplier,
        'address': address,
        'status': status,
      },
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
}
