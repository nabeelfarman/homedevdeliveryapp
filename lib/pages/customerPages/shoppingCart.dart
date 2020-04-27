import 'package:flutter/material.dart';
import 'package:homemobileapp/Animation/FadeinAnimation.dart';
import 'package:homemobileapp/UI/bottom_bar.dart';
import 'package:homemobileapp/pages/customerPages/itemsPage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../main.dart';

class ShoppingCart extends StatefulWidget {
  final int customerID;
  @override
  ShoppingCart({@required this.customerID});
  @override
  _ShoppingCartState createState() => _ShoppingCartState(this.customerID);
}

class _ShoppingCartState extends State<ShoppingCart>
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
  int customerID;
  String companyName;

  ProgressDialog pr;

  _ShoppingCartState(this.customerID);

  List cart_items = [];

  List cartItems = List();
  double totalAmount = 0.0;
  final formatter = new NumberFormat('##,###.##');

  @override
  void initState() {
    super.initState();
    this.getCartItems();
  }

  @override
  Future<String> getCartItems() async {
    try {
      Future.delayed(Duration(seconds: 1)).then((value) {
        pr.show();
      });
      var response = await http.get(
          "http://95.217.147.105:2001/api/getcartprod?CustomerID=" +
              customerID.toString(),
          headers: {
            "Content-Type": "application/json",
          });
      var responseJson = json.decode(response.body);

      for (int i = 0; i < responseJson.length; i++) {
        companyName = responseJson[i]["companyName"];
        cart_items.add({
          'itemCode': responseJson[i]["productProfileStoreID"],
          'itemTitle': responseJson[i]["productName"],
          'price': responseJson[i]["salePrice"].toString(),
          'unit': responseJson[i]["measurementUnit"],
          'quantity': responseJson[i]["qty"].toString(),
        });
      }

      setState(() {
        cartItems = cart_items;

        this.shoppingSum();
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

  void shoppingSum() {
    totalAmount = 0.0;
    try {
      for (int i = 0; i < cartItems.length; i++) {
        var item = cartItems[i];
        totalAmount +=
            double.parse(item['price']) * double.parse(item['quantity']);
      }
    } catch (e) {
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
        backgroundColor: darkYellowClr,
        title: Text('Shopping Cart',
            style:
                TextStyle(color: blackClr, fontFamily: 'Anton', fontSize: 25)),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     navigateToItems(context);
          //   },
          //   color: redClr,
          // )
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
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) =>
                  buildItemCard(context, index),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: blackClr,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 80,
          color: blackClr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Total Amount',
                style: TextStyle(
                    fontFamily: 'Baloo',
                    fontWeight: FontWeight.w300,
                    fontSize: 17,
                    color: whiteClr),
              ),
              Text(
                'Rs. ' + formatter.format(totalAmount).toString(),
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: lightYellowClr),
              ),
              RaisedButton(
                elevation: 10,
                color: redClr,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  if (cartItems.length > 0) {
                    navigateToOrderPlacement(context);
                  }
                },
                child: Text(
                  'Check Out',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Baloo', color: whiteClr, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemCard(BuildContext context, int index) {
    final item = cartItems[index];
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
                    Text(item['itemTitle'],
                        style: TextStyle(
                            color: blackClr,
                            fontFamily: 'Baloo',
                            fontSize: 18,
                            fontWeight: FontWeight.w800)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Rs. ' + item['price'],
                        style: TextStyle(
                            color: blackClr,
                            fontFamily: 'Baloo',
                            fontSize: 18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: lightClr,
                          shape: CircleBorder(),
                          onPressed: () {
                            setState(() {
                              int qty = int.parse(item['quantity']);

                              if (qty > 0) {
                                item['quantity'] = (qty - 1).toString();
                                shoppingSum();
                              }
                            });
                          },
                          child: Text(
                            '-',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Text(
                          item['quantity'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Baloo'),
                        ),
                        RaisedButton(
                          color: greenClr,
                          shape: CircleBorder(),
                          onPressed: () {
                            setState(() {
                              var qty = int.parse(item['quantity']);
                              if (qty < 500) {
                                item['quantity'] = (qty + 1).toString();
                                shoppingSum();
                              }
                            });
                          },
                          child: Text(
                            '+',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Rs. ' +
                          formatter
                              .format(double.parse(item['price']) *
                                  double.parse(item['quantity']))
                              .toString(),
                      style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  void navigateToItems(BuildContext context) {
    Routes.sailor.navigate('/item');
  }

  void navigateToOrderPlacement(BuildContext context) {
    Routes.sailor.navigate(
      '/orderPlacement',
      params: {
        'customerID': customerID,
        'companyName': companyName,
        'totalAmount': totalAmount,
      },
    );
  }
}
