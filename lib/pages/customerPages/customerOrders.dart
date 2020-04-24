import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/bottom_bar.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../main.dart';

class CustomerOrders extends StatefulWidget {
  final int userID;
  final int townID;

  @override
  CustomerOrders({
    @required this.userID,
    @required this.townID,
  });

  @override
  _CustomerOrdersState createState() => _CustomerOrdersState(
        this.userID,
        this.townID,
      );
}

class _CustomerOrdersState extends State<CustomerOrders>
    with SingleTickerProviderStateMixin {
  Color blackClr = Color(0xff2d2d2d);
  // Color yellowClr = Color(0xfff7d73a);
  Color whiteClr = Color(0x0ffffffff);
  Color lightClr = Color(0x0fffdebe7);
  Color purpleClr = Color(0x0ffd183fd);
  Color greenClr = Color(0x0ff8ee269);
  Color redClr = Color(0x0fff0513c);

  String pageName = 'customerOrder';
  int userID;
  int townID;
  String orderNo;
  String supplier;
  String address;

  _CustomerOrdersState(
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
      var response = await http.get(
          "http://95.217.147.105:2001/api/getcusorders?CustomerID=" +
              userID.toString(),
          headers: {
            "Content-Type": "application/json",
          });

      // pr.show();
      var responseJson = json.decode(response.body);

      for (int i = 0; i < responseJson.length; i++) {
        String orderStatus = "";
        if (responseJson[i]["oStatus"] == 1 &&
            responseJson[i]["cStatus"] == 0 &&
            responseJson[i]["dStatus"] == 0) {
          orderStatus = "pending";
        } else if (responseJson[i]["oStatus"] == 2 &&
            responseJson[i]["cStatus"] == 0 &&
            responseJson[i]["dStatus"] == 0) {
          orderStatus = "Cancel";
        } else if (responseJson[i]["oStatus"] == 1 &&
            responseJson[i]["cStatus"] == 1 &&
            responseJson[i]["dStatus"] == 0) {
          orderStatus = "confirm";
        } else if (responseJson[i]["oStatus"] == 1 &&
            responseJson[i]["cStatus"] == 2 &&
            responseJson[i]["dStatus"] == 0) {
          orderStatus = "rejected";
        } else if (responseJson[i]["oStatus"] == 1 &&
            responseJson[i]["cStatus"] == 1 &&
            responseJson[i]["dStatus"] == 1) {
          orderStatus = "completed";
        }

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
      pr.hide();

      setState(() {
        // pr.hide();

        customerOrdersList = customer_orders;
      });

      return 'success';
    } catch (e) {
      pr.hide();

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
        valueColor: new AlwaysStoppedAnimation<Color>(greenClr),
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
        centerTitle: true,
        elevation: 0,
        backgroundColor: whiteClr,
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
            child: new ListView.builder(
              itemCount: customerOrdersList.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildOrderCard(context, index),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                    item['orderStatus'] == 'pending'
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
                        : item['orderStatus'] == 'completed'
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

  void navigateToOrderDetail(BuildContext context) {
    Routes.sailor.navigate(
      '/orderDetail',
      params: {
        'orderNo': orderNo,
        'supplier': supplier,
        'address': address,
      },
    );
  }
}
